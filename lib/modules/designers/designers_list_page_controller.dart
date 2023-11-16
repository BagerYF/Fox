import 'dart:async';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/designers/designers_map.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DesignersListPageController extends GetxController {
  List<DesignerModel> originList = [];
  List<DesignerModel> dataList = [];
  var initDone = false;

  final ItemScrollController itemScrollController = ItemScrollController();
  final TextEditingController textEditingController = TextEditingController();

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
  void dispose() {
    keyboardSubscription.cancel();
    textEditingController.dispose();
    super.dispose();
  }

  initData() async {
    List<dynamic> tempDesigners = kDesignersAllMaps.keys.toList();
    List<String> designers = tempDesigners.map((e) => e.toString()).toList();
    var wordList = [];
    var numList = [];
    for (var item in designers) {
      String tag = item.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        wordList.add(item);
      } else {
        numList.add(item);
      }
    }
    wordList.sort();
    numList.sort();
    designers = [...wordList, ...numList];
    var list = designers.map((e) => DesignerModel.fromName(e)).toList();
    _formatData(list);
    initDone = true;
    update();
  }

  _formatData(list) {
    originList = [];
    for (var model in list) {
      String tag = model.name!.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        model.tagIndex = tag;
      } else {
        model.tagIndex = "#";
      }
      originList.add(model);
    }
    _handleList(originList);
  }

  _handleList(List<DesignerModel> list) {
    dataList.clear();

    dataList.addAll(list);

    SuspensionUtil.setShowSuspensionStatus(dataList);

    update();

    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(index: 0);
    }
  }

  search(String text) {
    if (text.isEmpty) {
      _handleList(originList);
    } else {
      List<DesignerModel> list = originList.where((v) {
        return v.name!.toLowerCase().contains(text.toLowerCase());
      }).toList();
      _handleList(list);
    }
  }
}
