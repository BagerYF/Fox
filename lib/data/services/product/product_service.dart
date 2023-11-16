import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/product_schema.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/product/model/product_model.dart';

class ProductService {
  Future<ProductList> getProductList(Map<String, dynamic> params,
      {LoadingType loadingType = LoadingType.none}) async {
    var query = params['query'];
    if (query.length > 0) {
      QueryResult response = await GQLProvider().client.query(
            schema: ProductSchemas.productList,
            variables: params,
            loadingType: loadingType,
          );
      var productList = ProductList.fromJson(response.data?['products']);
      return productList;
    } else {
      QueryResult response = await GQLProvider().client.query(
            schema: ProductSchemas.productListByCollection,
            variables: params,
            loadingType: loadingType,
          );
      var productList =
          ProductList.fromJson(response.data?['collection']['products']);
      return productList;
    }
  }

  getProductDetail(String id) async {
    QueryResult response = await GQLProvider().client.query(
      schema: ProductSchemas.productDetail,
      variables: {'id': id},
    );
    var product = Product.fromJson(response.data?['product']);
    return product;
  }

  Future<List<Product>> getRecommendedList(String id) async {
    QueryResult response = await GQLProvider().client.query(
      schema: ProductSchemas.recommendedList,
      variables: {'productId': id},
    );
    var tempList = response.data?['productRecommendations'];
    List<Product> productList =
        tempList.map<Product>((e) => Product.fromJson(e)).toList();
    return productList;
  }
}
