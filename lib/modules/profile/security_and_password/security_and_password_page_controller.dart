import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/input/input_model.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/rounded_loading_button.dart';

class SecurityAndPasswordPageController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  var txt = 'Update Password';

  var helpInputTitleList = [
    ['Current Password'],
    ['New Password'],
    ['Confirm Password'],
  ];
  final helpFormKey = GlobalKey<FormState>();
  List<List<InputItemModel>> helpInputList = [];

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
    initData();

    super.onInit();
  }

  @override
  void onClose() {
    keyboardSubscription.cancel();
    super.onClose();
  }

  initData() {
    helpInputList = getInputItemModelList(helpInputTitleList);
  }

  getInputItemModelList(List<List<String>> titleList) {
    List<List<InputItemModel>> tempAllList = [];
    for (var item in titleList) {
      List<InputItemModel> tempList = [];
      for (var i in item) {
        InputItemModel addressItem = InputItemModel.fromJson({
          'show': true,
          'name': i,
          'controller': TextEditingController(text: ''),
          'optional': (i == 'Apartment, Suite, Unit, Building' || i == 'Phone')
              ? true
              : false,
          'titleTextStyle': AppTextStyle.Black12,
          'showTitle': true,
          'key': GlobalKey(),
          'obscure': true,
        });
        if (i == 'Phone') {
          addressItem.placeorderName = 'Phone number';
        }
        tempList.add(addressItem);
      }
      tempAllList.add(tempList);
    }
    return tempAllList;
  }

  sendClick() async {
    if (txt != 'Update Password') {
      return;
    }

    var result = helpFormKey.currentState?.validate();

    if (result == false) {
      for (var item in helpInputList) {
        for (var i in item) {
          if (i.controller!.text.isEmpty) {
            Scrollable.ensureVisible(i.key!.currentContext!);
            return;
          }
        }
      }
    } else {
      btnController.start();

      // to do

      btnController.success();

      Timer(
        const Duration(seconds: 2),
        () {
          btnController.reset();
          txt = 'Password Changed';
          update();
          Timer(
            const Duration(seconds: 2),
            () {
              txt = 'Update Password';
              update();
              Get.back();
            },
          );
        },
      );
    }
  }
}
