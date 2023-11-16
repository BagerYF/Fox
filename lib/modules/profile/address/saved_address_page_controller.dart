import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/address/country_map.dart';
import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/services/address/address_service.dart';
import 'package:fox/data/services/localization/localization_service.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/routes/routers.dart';

enum PageStatus {
  init,
  normal,
  empty,
}

class SavedAddressPageController extends GetxController {
  List<AddressModel> addressList = [];
  List<Country> countryList = [];
  PageStatus pageStatus = PageStatus.init;
  RefreshController refreshController = RefreshController();
  var idleText = 'Pull down to refresh';
  var haveDefaultAddress = false;

  @override
  void onInit() {
    queryAddressList();
    super.onInit();
  }

  refreshCompleted() {
    refreshController.refreshCompleted(resetFooterState: true);
  }

  queryAddressList({
    LoadingType loadingType = LoadingType.transparent,
  }) async {
    var tempCountryList = kCountryMaps.map((v) => Country.fromJson(v)).toList();
    var localizationList = await LocalizationService().getLocalizationList();
    for (var local in localizationList) {
      for (var country in tempCountryList) {
        if (country.code == local.isoCode) {
          countryList.add(country);
          break;
        }
      }
    }

    await LoginController.to.queryCustomer(loadingType: loadingType);
    addressList = LoginController.to.customer?.address ?? [];
    if (addressList.isNotEmpty) {
      pageStatus = PageStatus.normal;
    } else {
      pageStatus = PageStatus.empty;
    }
    update();
  }

  getToDetail(int index) async {
    var result = await Get.toNamed(
      AppRouters.savedAddressDetailPage,
      arguments: {
        'formProfile': true,
        'addressModel': index == -1 ? null : addressList[index],
        'countryList': countryList,
        'isFirst': addressList.isEmpty ? true : false,
      },
    );
    if (result != null) {
      queryAddressList(loadingType: LoadingType.display);
    }
  }

  removeAddress(int index) async {
    await AddressService.customerAddressDelete(
      token: LoginController.to.token?.accessToken,
      id: addressList[index].id,
    );

    addressList.removeAt(index);
    update();
    queryAddressList();
  }
}
