import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/theme/styles/styles.dart';

class LoadingService {
  init(LoadingType loadingType) {
    EasyLoading.instance
      ..userInteractions = loadingType == LoadingType.none ? true : false
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 20
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..backgroundColor = Colors.transparent
      ..lineWidth = 2
      ..textColor = loadingType == LoadingType.display
          ? AppColors.BLACK
          : Colors.transparent
      ..indicatorColor = loadingType == LoadingType.display
          ? AppColors.BLACK
          : Colors.transparent
      ..boxShadow = [const BoxShadow(color: Colors.transparent)]
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..contentPadding =
          const EdgeInsets.only(top: 15, left: 15, bottom: 0, right: 15)
      ..fontSize = 16.0
      ..textPadding = const EdgeInsets.only(bottom: 22.0);
  }

  show(LoadingType loadingType, {String message = ''}) {
    init(loadingType);
    EasyLoading.show(status: message);
  }

  dismiss() {
    EasyLoading.dismiss();
  }
}
