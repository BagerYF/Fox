import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/checkout_schema.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/checkout/checkout_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class CheckoutService {
  Future<AddressModel?> getShippingAddress() async {
    var address = await LocalStorage()
        .getStorage(AppString.LOCALSTORAGE_CACHE_SHIPPING_ADDRESS);
    if (address != null) {
      return AddressModel.fromJson(address);
    }
    return address;
  }

  setShippingAddress(AddressModel address) async {
    await LocalStorage().setObject(
        AppString.LOCALSTORAGE_CACHE_SHIPPING_ADDRESS, address.toJson());
  }

  removeShippingAddress() {
    LocalStorage().removeStorage(AppString.LOCALSTORAGE_CACHE_SHIPPING_ADDRESS);
  }

  static Future<Checkout> checkoutCreate({
    Map<String, dynamic>? params,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutCreate,
          variables: {
            'input': params,
          },
          loadingType: LoadingType.transparent,
        );
    return Checkout.fromJson(response.data!['checkoutCreate']['checkout']);
  }

  static Future<Checkout> checkoutShippingAddressUpdate({
    Map<String, dynamic>? params,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutShippingAddressUpdate,
          variables: params,
          loadingType: LoadingType.transparent,
        );
    return Checkout.fromJson(
        response.data!['checkoutShippingAddressUpdateV2']['checkout']);
  }

  static Future<Checkout> checkoutShippingLines({
    Map<String, dynamic>? params,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutShippingLines,
          variables: params,
          loadingType: LoadingType.transparent,
        );
    return Checkout.fromJson(response.data!['node']);
  }

  static Future<Checkout> checkoutShippingLineUpdate({
    Map<String, dynamic>? params,
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutShippingLineUpdate,
          variables: params,
          loadingType: loadingType,
        );
    return Checkout.fromJson(
        response.data!['checkoutShippingLineUpdate']['checkout']);
  }

  static Future<Checkout> checkoutDiscountCodeApplyV2({
    Map<String, dynamic>? params,
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutDiscountCodeApplyV2,
          variables: params,
          loadingType: loadingType,
        );
    var errors =
        response.data!['checkoutDiscountCodeApplyV2']['checkoutUserErrors'];
    if (errors != null && errors.length > 0) {
      throw ExceptionModel(
        type: ExceptionType.server,
      );
    }
    return Checkout.fromJson(
        response.data!['checkoutDiscountCodeApplyV2']['checkout']);
  }

  static Future<Checkout> checkoutDiscountCodeRemove({
    Map<String, dynamic>? params,
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutDiscountCodeRemove,
          variables: params,
          loadingType: loadingType,
        );
    return Checkout.fromJson(
        response.data!['checkoutDiscountCodeRemove']['checkout']);
  }

  static Future<Checkout> checkoutCustomerAssociate({
    Map<String, dynamic>? params,
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutCustomerAssociateV2,
          variables: params,
          loadingType: loadingType,
        );
    return Checkout.fromJson(
        response.data!['checkoutCustomerAssociateV2']['checkout']);
  }

  static Future<Checkout> checkoutCompleteFree({
    Map<String, dynamic>? params,
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutCompleteFree,
          variables: params,
          loadingType: loadingType,
        );
    return Checkout.fromJson(
        response.data!['checkoutCompleteFree']['checkout']);
  }

  static Future<Checkout> checkoutCompleteWithCreditCard({
    Map<String, dynamic>? params,
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    QueryResult response = await GQLProvider().client.mutate(
          schema: CheckoutSchemas.checkoutCompleteWithCreditCardV2,
          variables: params,
          loadingType: loadingType,
        );
    return Checkout.fromJson(
        response.data!['checkoutCompleteWithCreditCardV2']['checkout']);
  }
}
