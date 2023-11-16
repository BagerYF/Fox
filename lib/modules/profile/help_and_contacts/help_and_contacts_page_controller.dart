import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/exception/exception_model.dart';
import 'package:fox/data/model/input/input_model.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/rounded_loading_button.dart';
import 'package:fox/utils/widget/single_pickview.dart';

class HelpAndContactsPageController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  var txt = 'Send';

  var helpInputTitleListUp = [
    ['Name'],
    ['Email'],
    ['Phone Number'],
  ];

  var helpInputTitleList = [
    ['Order Number'],
  ];

  var helpInputTitleListDown = [
    ['Enquiry Type'],
    ['Message'],
  ];

  var typeList = [
    'Trouble placing an order',
    'Product information',
    'Status of my order',
    'Delivery tracking',
    'Product I received',
    'Returns',
    'Refunds',
    'Change my address',
  ];

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  int showOrder = 0;
  bool showErrorMsg = false;
  bool showTipMsg = false;

  var selectTypeIndex = 0;

  final helpFormKey = GlobalKey<FormState>();
  List<List<InputItemModel>> helpInputListUp = [];
  List<List<InputItemModel>> helpInputList = [];
  List<List<InputItemModel>> helpInputListDown = [];
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
    helpInputListUp = getInputItemModelList(helpInputTitleListUp);
    helpInputList = getInputItemModelList(helpInputTitleList);
    helpInputListDown = getInputItemModelList(helpInputTitleListDown);
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
          if (i == 'Email') 'placeorderName': 'Email Address',
          if (i == 'Phone') 'placeorderName': 'Phone Number',
          if (i == 'Email') 'invalidEmail': true,
        });
        if (i == 'Phone') {
          addressItem.placeorderName = 'Phone number';
          addressItem.textInputType = TextInputType.number;
        }
        if (i == 'Name') {
          addressItem.errorMsg = 'Please enter your name';

          addressItem.focusNode = focusNodes[0];
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Email') {
          addressItem.invalidEmail = true;
          addressItem.errorMsg = 'Please enter a valid email address';
          addressItem.focusNode = focusNodes[1];
          addressItem.textInputType = TextInputType.emailAddress;
          addressItem.textInputAction = TextInputAction.next;
        }
        if (i == 'Phone Number') {
          addressItem.optional = true;
          addressItem.focusNode = focusNodes[2];
        }
        if (i == 'Order Number') {
          addressItem.errorMsg = 'Please enter your order number';
        }
        if (i == 'Message') {
          addressItem.errorLineColor = AppColors.WHITE;
          addressItem.lineColor = AppColors.WHITE;
          addressItem.lines = 10000;
          addressItem.placeorderName = 'Type your message here';
          addressItem.errorMsg = 'Please enter a message';
          addressItem.focusNode = focusNodes[3];
        }
        if (i == 'Enquiry Type') {
          addressItem.placeorderName = 'Tell us about your enquiry';
          addressItem.errorMsg = 'Please select an enquiry type';
          addressItem.onTap = selectType;
          addressItem.suffixIcon = Container(
            margin: const EdgeInsets.only(top: 16, right: 5),
            child: Image.asset(
              LocalImages.asset('arrow_down'),
            ),
          );
        }
        tempList.add(addressItem);
      }
      tempAllList.add(tempList);
    }
    return tempAllList;
  }

  selectType() {
    Get.bottomSheet(
      SinglePickview(
        selectIndex: selectTypeIndex,
        pickItems: typeList,
        title: 'Please select an enquiry type',
        selectText: 'Select',
        callback: (index) {
          selectTypeIndex = index;
          helpInputListDown[0][0].controller?.text = typeList[index];
          update();
        },
      ),
      barrierColor: Colors.black.withOpacity(0.4),
    );
  }

  sendClick() async {
    if (txt != 'Send') {
      return;
    }

    if (showOrder == 0) {
      showErrorMsg = true;
    } else {
      showErrorMsg = false;
    }
    update();

    var result = helpFormKey.currentState?.validate();

    if (result == false) {
      for (var item in helpInputListUp) {
        for (var i in item) {
          if (i.controller!.text.isEmpty) {
            Scrollable.ensureVisible(i.key!.currentContext!);
            return;
          }
        }
      }
      if (showOrder == 1) {
        for (var item in helpInputList) {
          for (var i in item) {
            if (i.controller!.text.isEmpty) {
              Scrollable.ensureVisible(i.key!.currentContext!);
              return;
            }
          }
        }
      }
      for (var item in helpInputListDown) {
        for (var i in item) {
          if (i.controller!.text.isEmpty) {
            Scrollable.ensureVisible(i.key!.currentContext!);
            return;
          }
        }
      }
    } else {
      if (showOrder == 0) {
        return;
      }
      btnController.start();
      showTipMsg = false;

      try {
        await 1.seconds.delay();
      } on ExceptionModel catch (e) {
        btnController.reset();
        if (e.type == ExceptionType.back) {
        } else if (e.type == ExceptionType.retry) {
          sendClick();
        }
        return;
      } catch (e) {
        btnController.reset();
        return;
      }

      btnController.success();

      showTipMsg = true;
      update();
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    }
  }
}
