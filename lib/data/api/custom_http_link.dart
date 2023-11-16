import 'package:graphql/client.dart';
// ignore: depend_on_referenced_packages
import "package:http/http.dart" as http;
import "dart:convert";

typedef HttpCodeCallback = Function(int code);

/// A simple HttpLink implementation.
///
/// To use non-standard [Request] and [Response] shapes
/// you can override [serializeRequest], [parseResponse],
/// [parseError] and [parseLocation].
///
/// To customize the request headers you can pass a custom
/// [http.Client] to the constructor.
class CustomHttpLink extends Link {
  /// Endpoint of the GraphQL service
  final Uri uri;

  /// Default HTTP headers
  final Map<String, String> defaultHeaders;

  /// set to `true` to use the HTTP `GET` method for queries (but not for mutations)
  final bool useGETForQueries;

  /// Serializer used to serialize request
  final RequestSerializer serializer;

  /// Parser used to parse response
  final ResponseParser parser;

  /// A function that decodes the incoming http response to `Map<String, dynamic>`,
  /// the decoded map will be then passes to the `RequestSerializer`.
  /// It is recommended for performance to decode the response using `compute` function.
  /// ```
  /// httpResponseDecoder : (http.Response httpResponse) async => await compute(jsonDecode, httpResponse.body) as Map<String, dynamic>,
  /// ```
  HttpResponseDecoder httpResponseDecoder;

  HttpCodeCallback? httpCodeCallback;

  static Map<String, dynamic>? _defaultHttpResponseDecoder(
          http.Response httpResponse) =>
      json.decode(
        utf8.decode(
          httpResponse.bodyBytes,
        ),
      ) as Map<String, dynamic>?;

  http.Client? _httpClient;

  /// You can pass a [httpClient] to extend to customize the network request.
  CustomHttpLink(
    String uri, {
    this.defaultHeaders = const {},
    this.useGETForQueries = false,
    http.Client? httpClient,
    this.serializer = const RequestSerializer(),
    this.parser = const ResponseParser(),
    this.httpResponseDecoder = _defaultHttpResponseDecoder,
    this.httpCodeCallback,
  }) : uri = Uri.parse(uri) {
    _httpClient = httpClient ?? http.Client();
  }

  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) async* {
    final httpResponse = await _executeRequest(request);
    final response = await _parseHttpResponse(httpResponse);
    httpCodeCallback?.call(httpResponse.statusCode);
    if (httpResponse.statusCode >= 300 ||
        (response.data == null && response.errors == null)) {
      throw HttpLinkServerException(
        response: httpResponse,
        parsedResponse: response,
      );
    }

    yield Response(
      data: response.data,
      errors: response.errors,
      context: _updateResponseContext(response, httpResponse),
      response: response.response,
    );
  }

  Context _updateResponseContext(
    Response response,
    http.Response httpResponse,
  ) {
    try {
      return response.context.withEntry(
        HttpLinkResponseContext(
          statusCode: httpResponse.statusCode,
          headers: httpResponse.headers,
        ),
      );
    } catch (e) {
      throw ContextWriteException(
        originalException: e,
      );
    }
  }

  Future<Response> _parseHttpResponse(http.Response httpResponse) async {
    final responseBody = await httpResponseDecoder(httpResponse);
    return parser.parseResponse(responseBody!);
  }

  Future<http.Response> _executeRequest(Request request) async {
    final httpRequest = _prepareRequest(request);
    try {
      final response = await _httpClient!.send(httpRequest);
      return http.Response.fromStream(response);
    } catch (e) {
      throw ServerException(
        originalException: e,
        parsedResponse: null,
      );
    }
  }

  http.BaseRequest _prepareRequest(Request request) {
    final body = _encodeAttempter(
      request,
      serializer.serializeRequest,
    )(request);

    final contextHeaders = _getHttpLinkHeaders(request);
    final headers = {
      "Content-type": "application/json",
      "Accept": "*/*",
      ...defaultHeaders,
      ...contextHeaders,
    };

    final fileMap = extractFlattenedFileMap(body);

    final useGetForThisRequest =
        fileMap.isEmpty && useGETForQueries && request.isQuery;

    if (useGetForThisRequest) {
      return http.Request(
        "GET",
        uri.replace(
          queryParameters: _encodeAttempter(
            request,
            _encodeAsUriParams,
          )(body),
        ),
      )..headers.addAll(headers);
    }

    final httpBody = _encodeAttempter(
      request,
      (Map body) => json.encode(
        body,
        toEncodable: (dynamic object) =>
            (object is http.MultipartFile) ? null : object.toJson(),
      ),
    )(body);

    if (fileMap.isNotEmpty) {
      return http.MultipartRequest("POST", uri)
        ..body = httpBody
        ..addAllFiles(fileMap)
        ..headers.addAll(headers);
    }
    return http.Request("POST", uri)
      ..body = httpBody
      ..headers.addAll(headers);
  }

  /// wrap an encoding transform in exception handling
  T Function(V) _encodeAttempter<T, V>(
    Request request,
    T Function(V) encoder,
  ) =>
      (V input) {
        try {
          return encoder(input);
        } catch (e) {
          throw RequestFormatException(
            originalException: e,
            request: request,
          );
        }
      };

  /// Closes the underlining [http.Client]
  @override
  Future<void> dispose() async {
    _httpClient?.close();
  }
}

Map<String, String> _getHttpLinkHeaders(Request request) {
  try {
    final HttpLinkHeaders? linkHeaders = request.context.entry();

    return {
      if (linkHeaders != null) ...linkHeaders.headers,
    };
  } catch (e) {
    throw ContextReadException(
      originalException: e,
    );
  }
}

Map<String, String> _encodeAsUriParams(Map<String, dynamic> serialized) =>
    serialized.map<String, String>(
      (k, dynamic v) => MapEntry(k, v is String ? v : json.encode(v)),
    );

/// Recursively extract [MultipartFile]s and return them as a normalized map of [path] => [file]
/// From the given request body
///
/// ```dart
/// {
///   "foo": [ { "bar": MultipartFile("blah.txt") } ]
///  }
/// // =>
/// {
///   "foo.0.bar": MultipartFile("blah.txt")
/// }
/// ```
Map<String, http.MultipartFile> extractFlattenedFileMap(
  dynamic body, {
  Map<String, http.MultipartFile>? currentMap,
  List<String> currentPath = const <String>[],
}) {
  currentMap ??= <String, http.MultipartFile>{};
  if (body is Map<String, dynamic>) {
    final Iterable<MapEntry<String, dynamic>> entries = body.entries;
    for (final MapEntry<String, dynamic> element in entries) {
      currentMap.addAll(extractFlattenedFileMap(
        element.value,
        currentMap: currentMap,
        currentPath: List<String>.from(currentPath)..add(element.key),
      ));
    }
    return currentMap;
  }
  if (body is List<dynamic>) {
    for (int i = 0; i < body.length; i++) {
      currentMap.addAll(extractFlattenedFileMap(
        body[i],
        currentMap: currentMap,
        currentPath: List<String>.from(currentPath)..add(i.toString()),
      ));
    }
    return currentMap;
  }

  if (body is http.MultipartFile) {
    return currentMap
      ..addAll({
        currentPath.join("."): body,
      });
  }

  return currentMap;
}

extension AddAllFiles on http.MultipartRequest {
  void addAllFiles(Map<String, http.MultipartFile> fileMap) {
    final Map<String, List<String>> fileMapping = <String, List<String>>{};
    final List<http.MultipartFile> fileList = <http.MultipartFile>[];

    final List<MapEntry<String, http.MultipartFile>> fileMapEntries =
        fileMap.entries.toList(growable: false);

    for (int i = 0; i < fileMapEntries.length; i++) {
      final MapEntry<String, http.MultipartFile> entry = fileMapEntries[i];
      final String indexString = i.toString();
      fileMapping.addAll(<String, List<String>>{
        indexString: <String>[entry.key],
      });
      final http.MultipartFile f = entry.value;
      fileList.add(http.MultipartFile(
        indexString,
        f.finalize(),
        f.length,
        contentType: f.contentType,
        filename: f.filename,
      ));
    }

    fields["map"] = json.encode(fileMapping);

    files.addAll(fileList);
  }

  set body(String body) => fields["operations"] = body;
}
