import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:fox/config/config.dart';
import 'package:fox/data/api/schema/login_schema.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/data/services/loading/loading_service.dart';
import 'package:fox/data/services/network/network_service.dart';

class GQLProvider {
  static GQLProvider? _instance = GQLProvider._internal();

  factory GQLProvider() => _instance!;

  GQLProvider._internal();

  late GQLClient client = GQLClient();

  void dispose() {
    _instance = null;
  }
}

class GQLClient {
  //todo:need to add get token method
  static GraphQLCache cache = GraphQLCache(
      // dataIdFromObject: typenameDataIdFromObject,
      );
  static String appVersion = '';

  Future<GraphQLClient> client({String? tempToken}) async {
    final Link link = HttpLink(
      EnvironmentConfig.graphqlUrl,
      defaultHeaders: {
        'X-Shopify-Storefront-Access-Token': EnvironmentConfig.token,
      },
    );
    return GraphQLClient(
      cache: cache,
      link: link,
    );
  }

  // query
  Future<QueryResult> query({
    @required String? schema,
    Map<String, dynamic>? variables,
    LoadingType loadingType = LoadingType.transparent,
    String? tempToken,
    bool ignoreError = false,
    bool requestAgain = false,
  }) async {
    await NetworkService().checkNetwork();
    if (kDebugMode) {}

    QueryOptions options = QueryOptions(
      document: gql(schema!),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.noCache,
    );

    if (loadingType != LoadingType.none) LoadingService().show(loadingType);
    var graphQLClient = await client(tempToken: tempToken);
    QueryResult result = await graphQLClient
        .query(options)
        .timeout(const Duration(milliseconds: 30000), onTimeout: () async {
      if (loadingType != LoadingType.none) LoadingService().dismiss();
      if (ignoreError) {
        throw 'ignore throw error';
      } else {
        await NetworkService()
            .serverError(backable: true, message: 'Connection timeout.');
      }
      return graphQLClient.query(options);
    });

    if (loadingType != LoadingType.none) LoadingService().dismiss();
    if (result.hasException) {
      if (ignoreError) {
        throw 'ignore throw error';
      } else {
        var error = result.exception?.graphqlErrors ?? [];
        if (error.isNotEmpty) {
          var message = '';
          for (var element in error) {
            message += element.message;
          }
          await NetworkService().serverError(message: message);
        }
      }
    }

    return result;
  }

  // mutate
  Future<QueryResult> mutate({
    @required String? schema,
    Map<String, dynamic>? variables,
    LoadingType loadingType = LoadingType.display,
    bool requestAgain = false,
    bool applepay = false,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (applepay) {
        throw ExceptionModel(
            type: ExceptionType.server, message: 'No internet connection.');
      } else {
        await NetworkService().checkNetwork();
      }
    }

    MutationOptions options = MutationOptions(
      document: gql(schema!),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.noCache,
    );
    if (loadingType != LoadingType.none) LoadingService().show(loadingType);
    var graphQLClient = await client();
    QueryResult result = await graphQLClient
        .mutate(options)
        .timeout(const Duration(milliseconds: 30000), onTimeout: () async {
      if (loadingType != LoadingType.none) LoadingService().dismiss();

      if (applepay) {
        throw ExceptionModel(
            type: ExceptionType.server, message: 'Connection timeout.');
      } else {
        await NetworkService().serverError(message: 'Connection timeout.');
      }
      return graphQLClient.mutate(options);
    });

    if (loadingType != LoadingType.none) LoadingService().dismiss();

    if (result.hasException) {
      if (result.exception
              .toString()
              .contains('Unexpected character (at character 1)') &&
          requestAgain == false) {
        return await mutate(
            schema: schema,
            variables: variables,
            loadingType: loadingType,
            requestAgain: true);
      }
      await NetworkService().serverError(
          message: result.exception?.graphqlErrors[0].message ?? '');
    }

    if (schema == LoginSchema.customerCreate) {
      var error = result.data?['customerCreate']['customerUserErrors'];
      if (error.length > 0) {
        await NetworkService().serverError(message: error[0]['message'] ?? '');
      }
    }

    return result;
  }
}
