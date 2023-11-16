import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/services/loading/loading_service.dart';

class ServerErrorPageController extends GetxController {
  bool show = true;
  var msg = 'There was a problem with our server \n please try again';
  bool backable = true;

  @override
  void onInit() {
    LoadingService().dismiss();
    backable = Get.arguments['backable'];
    if (Get.arguments['message'] != null &&
        Get.arguments['message'].length > 0) {
      msg = Get.arguments['message'];
    }
    super.onInit();
  }

  retryClick() async {
    show = false;
    update();
    LoadingService().show(LoadingType.display);
    var network = await checkNetwork();
    Timer(const Duration(seconds: 1), () {
      LoadingService().dismiss();
      show = true;
      update();
      if (network) {
        Get.back(result: true);
      }
    });
  }

  checkNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
