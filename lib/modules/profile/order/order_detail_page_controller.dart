import 'package:get/get.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/order/order_model.dart';

class OrderDetailPageController extends GetxController {
  OrderModel? model;
  List<LineItemsModel> items = [];
  String appbarTitle = '';
  AddressModel? shippingAddress;

  String? shopifyOrderId;
  String? customerId;
  bool canReturn = false;
  bool requestComplete = false;
  bool haveClicked = false;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() async {
    model = Get.arguments as OrderModel;
    appbarTitle = '#${model?.orderNumber}';
    items = model?.lineItems ?? [];
    shippingAddress = model?.shippingAddress;
  }

  String getFulfillmentStatusValue(String? value) {
    if (value == null || value == "unFulfilled") {
      return "Unfulfilled";
    } else if (value == "partialFulfilled") {
      return "Partial Fulfilled";
    } else if (value == "fulfilled") {
      return "Fulfilled";
    } else {
      return value;
    }
  }
}
