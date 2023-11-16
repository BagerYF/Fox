import 'dart:async';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/data/model/region/model/region_model.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/utils/widget/rounded_loading_button.dart';

String imageUrlPrefix =
    'https://d1mp1ehq6zpjr9.cloudfront.net/static/images/flags/';

class RegionPageController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  var txt = 'Update Region';

  RegionModel? region;
  var regionStr = '';
  var regionImg = '';

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() {
    region = ProfilePageController.to.region;
    if (region != null) {
      regionStr =
          '${region?.name ?? ''}, ${region?.currencyCode ?? ''} ${region?.currency ?? ''}';
      regionImg = '$imageUrlPrefix${region?.code}.png';
    }
  }

  selectRegion() async {
    if (btnController.currentState == ButtonState.success) {
      return;
    }
  }

  saveRegion() async {
    btnController.start();

    try {
      await ProfilePageController.to.setCurrentRegion(region!);
    } on ExceptionModel catch (e) {
      btnController.reset();
      if (e.type == ExceptionType.back) {
      } else if (e.type == ExceptionType.retry) {
        saveRegion();
      }
      return;
    } catch (e) {
      btnController.reset();

      return;
    }

    btnController.success();

    Timer(
      const Duration(seconds: 2),
      () {
        Get.back();
      },
    );
  }
}
