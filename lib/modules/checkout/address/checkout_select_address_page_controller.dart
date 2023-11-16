import 'package:get/get.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/routes/routers.dart';

class CheckoutSelectAddressPageController extends GetxController {
  List<AddressModel> addressList = [];
  List<Country> countryList = [];

  late AddressModel selectShippingAddress;
  late AddressModel selectBillingAddress;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    countryList = Get.arguments['countryList'];
    selectShippingAddress = Get.arguments['shippingAddressModel'];
    selectBillingAddress = Get.arguments['billingAddressModel'];
    initAddressList();
  }

  initAddressList() async {
    addressList = [];
    for (var item in addressList) {
      item.selected = false;
      item.billSelected = false;
    }

    for (var item in addressList) {
      var result = await compareAddress(item, selectBillingAddress);
      if (result == true) {
        item.billSelected = true;
        break;
      }
    }

    for (var item in addressList) {
      var result = await compareAddress(item, selectShippingAddress);
      if (result == true) {
        item.selected = true;
        break;
      }
    }

    update();
  }

  compareAddress(AddressModel addOne, AddressModel addTwo) {
    if (addOne.toEqualJson() == addTwo.toEqualJson()) {
      return true;
    } else {
      return false;
    }
  }

  addAddress() async {
    var result = await Get.toNamed(
      AppRouters.savedAddressDetailPage,
      arguments: {
        'countryList': countryList,
      },
    );
    if (result != null) {
      selectBillingAddress = result as AddressModel;
      await refreshAddressList();
      selectAddress(selectBillingAddress);
    }
  }

  refreshAddressList() async {}

  selectAddress(AddressModel address) async {}
}
