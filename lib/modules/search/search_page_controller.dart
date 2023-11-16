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

// ignore: constant_identifier_names
enum SearchStatus { Normal, Searching, Success, Faild }

class SearchPageController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController tabController;

  List<CategoryModel> originList = [];
  List<CategoryModel> dataList = [];
  List<CategoryModel> firstLevelCategoryList = [];
  List<CategoryModel>? secondLevelCategoryList = [];
  List<SearchHistoryModel> historyList = [];
  List<DesignerModel> suggestedList = [];
  List<DesignerModel> designersList = [];
  List<Product> productsList = [];

  SearchStatus searchStatus = SearchStatus.Normal;

  var showNav = true;
  @override
  void onInit() {
    initData();

    super.onInit();
  }

  initData() async {
    await getCategoryList();
    await getHistoryList();
    getSuggestedList();
  }

  getCategoryList() {
    firstLevelCategoryList =
        kCategoryMaps.map((e) => CategoryModel.fromJson(e)).toList();
    firstLevelCategoryList.first.selected = true;
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
    // todo search
  }

  submit(String text) async {
    // todo submit
  }
}
