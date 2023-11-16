import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/address_schema.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/enum/enum.dart';

class AddressService {
  static Future<Map<String, dynamic>> customerAddressCreate({
    AddressModel? address,
    String? token,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: AddressSchema.customerAddressCreate,
          variables: {
            'customerAccessToken': token,
            'address': address?.toJson(),
          },
          loadingType: LoadingType.transparent,
        );
    return response.data!;
  }

  static Future<Map<String, dynamic>> updateAccountAddressBookEntry({
    AddressModel? address,
    String? token,
    String? id,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: AddressSchema.customerAddressUpdate,
          variables: {
            'customerAccessToken': token,
            'id': id,
            'address': address?.toJson(),
          },
          loadingType: LoadingType.transparent,
        );
    return response.data!;
  }

  static Future<Map<String, dynamic>> customerAddressDelete({
    String? token,
    String? id,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: AddressSchema.customerAddressDelete,
          variables: {
            'customerAccessToken': token,
            'id': id,
          },
          loadingType: LoadingType.display,
        );
    return response.data!;
  }
}
