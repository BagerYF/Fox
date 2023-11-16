import 'package:devicelocale/devicelocale.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:fox/data/model/region/model/region_model.dart';
import 'package:fox/data/services/region/region_service.dart';
import 'package:fox/modules/login/login_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class ProfilePageController extends GetxController {
  static ProfilePageController get to => Get.find<ProfilePageController>();

  bool isLogin = false;

  // ignore: non_constant_identifier_names
  var REGION = 'region';
  var region = RegionModel(
      code: 'CN',
      currencyCode: 'USD',
      regionCode: 'www',
      name: 'China',
      currency: '\$',
      isFreeReturn: true);

  String? _appVersion;

  get appVersion {
    return _appVersion;
  }

  @override
  void onInit() {
    getCurrentRegion();
    getAppVersion();
    super.onInit();
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
  }

  setCurrentRegion(RegionModel newRegion) async {
    region = newRegion;
    LocalStorage().setObject(REGION, region);
  }

  getCurrentRegion() async {
    Map<String, dynamic>? regionStr = await LocalStorage().getStorage(REGION);
    if (regionStr != null) {
      region = RegionModel.fromJson(regionStr);
    } else {
      var regionList = await RegionService().getRegionList();
      var locale = await Devicelocale.currentAsLocale;
      if (locale != null) {
        var localeCode = locale.countryCode;
        for (var v in regionList) {
          if (v.code == localeCode) {
            region = v;
          }
        }
      }

      // ignore: unnecessary_null_comparison
      if (region == null) {
        for (var v in regionList) {
          if (v.code == 'US') {
            region = v;
          }
        }
      }
    }
  }

  setRegion(RegionModel? region) async {}

  removeRegion() {
    LocalStorage().removeStorage(REGION);
  }

  String displayName() {
    if (isLogin) {
      return LoginController.to.customer?.displayName ?? '';
    } else {
      return 'Name of user';
    }
  }

  login({bool isRegist = false}) async {
    LoginController.to.login(isRegist: isRegist);
    await Get.toNamed(AppRouters.loginPage);
    update();
  }

  logout() async {
    LoginController.to.logout();
    isLogin = false;
    update();
  }
}
