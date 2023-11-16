import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/address/model/address_model.dart';

class CheckoutCountryPageController extends GetxController {
  List<Country> countryList = [];

  final TextEditingController textEditingController = TextEditingController();
  var searchPhrase = '';
  late StreamSubscription<bool> keyboardSubscription;

  var showKeyboard = false;

  @override
  void onInit() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      showKeyboard = visible;
      update();
    });
    countryList = Get.arguments;

    super.onInit();
  }

  @override
  void onClose() {
    keyboardSubscription.cancel();
    super.onClose();
  }

  void searchText(String text) {
    searchPhrase = text;
    update();
  }

  void clearSearchText() {
    textEditingController.text = '';
    searchPhrase = '';
    update();
  }
}
