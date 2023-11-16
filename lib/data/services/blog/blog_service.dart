import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/blog_schema.dart';
import 'package:fox/data/model/blog/blog_model.dart';
import 'package:fox/data/model/enum/enum.dart';

class BlogService {
  Future<BlogList> getBlogList(Map<String, dynamic> params,
      {LoadingType loadingType = LoadingType.none}) async {
    QueryResult response = await GQLProvider().client.query(
          schema: BlogSchema.blogs,
          variables: params,
          loadingType: loadingType,
        );
    var blogList = BlogList.fromJson(response.data?['blogs']);
    return blogList;
  }
}
