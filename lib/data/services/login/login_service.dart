import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/login_schema.dart';
import 'package:fox/data/model/Customer/Customer_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/token/token_model.dart';

class LoginService {
  customerCreate(Map<String, dynamic> params) async {
    QueryResult response = await GQLProvider().client.mutate(
      schema: LoginSchema.customerCreate,
      variables: {'input': params},
    );
    var result = response.data?['customerCreate'];
    return result;
  }

  Future<TokenModel> customerAccessTokenCreate(
      Map<String, dynamic> params) async {
    QueryResult response = await GQLProvider().client.mutate(
      schema: LoginSchema.customerAccessTokenCreate,
      variables: {'input': params},
    );
    var result = TokenModel.fromJson(
        response.data?['customerAccessTokenCreate']['customerAccessToken']);
    return result;
  }

  queryCustomer(
    Map<String, dynamic> params, {
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.query(
          schema: LoginSchema.customer,
          variables: params,
          loadingType: loadingType,
        );
    var result = CustomerModel.fromJson(response.data?['customer']);
    return result;
  }
}
