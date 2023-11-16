import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/data/model/category/category_map.dart';
import 'package:fox/data/model/category/model/category_model.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/data/model/search/model/search_model.dart';
import 'package:fox/data/model/search/suggested_map.dart';
import 'package:fox/data/services/search/search_service.dart';
import 'package:fox/modules/search/widget/search_fail.dart';
import 'package:fox/modules/search/widget/search_normal.dart';
import 'package:fox/modules/search/widget/search_success.dart';
import 'package:fox/modules/search/widget/searching.dart';
import 'package:fox/routes/routers.dart';

// ignore: constant_identifier_names
enum SearchStatus { Normal, Searching, Success, Faild }

class SearchingPageController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  late TabController tabController;

  List<CategoryModel> originList = [];
  List<CategoryModel> dataList = [];
  List<CategoryModel> firstLevelCategoryList = [];
  List<CategoryModel>? secondLevelCategoryList = [];
  List<SearchHistoryModel> historyList = [];
  List<DesignerModel> suggestedList = [];
  List<DesignerModel> designersList = [];
  List<Product> productsList = [];

  var push = false;

  SearchStatus searchStatus = SearchStatus.Searching;

  var showFirstView = true;
  int focusNodeChangeTime = 0;

  AnimationController? animationController;
  Animation<double>? animationTop;
  Animation<double>? animationBtnWidth;

  @override
  void onInit() {
    initAnimation();
    initData();
    focusNode.addListener(() {
      focusNodeChangeTime = DateTime.now().millisecondsSinceEpoch;
      if (focusNode.hasFocus) {
        search(textEditingController.text);
        update();
      } else {
        if (!push) {}
      }
    });
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  initAnimation() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);

    animationTop = CurvedAnimation(
        parent: animationController!,
        curve: Curves.elasticInOut,
        reverseCurve: Curves.easeOut);

    animationTop?.addListener(() {
      update();
    });

    animationBtnWidth?.addListener(() {
      update();
    });

    animationTop = Tween(begin: 59.5, end: 4.0).animate(animationController!);
    animationBtnWidth =
        Tween(begin: 0.0, end: 70.0).animate(animationController!);

    animationController?.forward();
  }

  @override
  void onReady() {
    focusNode.requestFocus();
    super.onReady();
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (MediaQuery.of(Get.context!).viewInsets.bottom == 0) {
        int space = DateTime.now().millisecondsSinceEpoch - focusNodeChangeTime;
        if (space > 300 && focusNode.hasFocus) {
          focusNode.unfocus();
        }
      }
    });
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    animationController?.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  initData() async {
    await getCategoryList();
    await getHistoryList();
    getSuggestedList();
  }

  getCategoryList() {
    firstLevelCategoryList =
        kCategoryMaps.map((e) => CategoryModel.fromJson(e)).toList();
    if (firstLevelCategoryList.isNotEmpty) {
      tabController =
          TabController(length: firstLevelCategoryList.length, vsync: this);

      secondLevelCategoryList = firstLevelCategoryList[0].children;
    }
    update();
  }

  getHistoryList() async {
    historyList = await SearchService().getSearchHistoryList();
    update();
  }

  getSuggestedList() {
    List<String> localList = kSuggestedMaps.map((e) => e).toList();
    localList.sort();
    suggestedList = localList.map((e) => DesignerModel.fromName(e)).toList();
    update();
  }

  get bodyViews {
    Widget bodyView;
    switch (searchStatus) {
      case SearchStatus.Normal:
        bodyView = SearchNormal();
        break;
      case SearchStatus.Searching:
        bodyView = Searching();
        break;
      case SearchStatus.Success:
        bodyView = SearchSuccess();
        break;
      case SearchStatus.Faild:
        bodyView = SearchFail();
        break;
      default:
        bodyView = const SizedBox();
    }
    return bodyView;
  }

  search(String text) async {
    update();
    if (text.isEmpty) {
      designersList.clear();
      productsList.clear();
      searchStatus = SearchStatus.Searching;
      update();
      return;
    }
  }

  submit(String text) async {
    if (text.isNotEmpty) {
      await SearchService().setSearchHistory(text);
      getHistoryList();

      await Get.toNamed(AppRouters.productList, arguments: {'query': text});
      FocusScopeNode currentFocus = FocusScope.of(Get.context!);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }
}
