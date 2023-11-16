import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/services/loading/loading_service.dart';

class NetworkPageController extends GetxController {
  bool show = true;
  bool backable = true;
  late dynamic subscription;

  @override
  void onInit() {
    LoadingService().dismiss();
    backable = Get.arguments['backable'];
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        retryClick();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
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
