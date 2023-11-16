import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/home/home_map.dart';
import 'package:fox/data/model/home/model/home_model.dart';
import 'package:fox/data/services/localization/localization_service.dart';
import 'package:fox/modules/home/widget/home_section.dart';
import 'package:fox/modules/home/widget/home_sections.dart';
import 'package:fox/routes/routers.dart';

class HomepageController extends GetxController
    with GetTickerProviderStateMixin {
  static HomepageController get to => Get.find<HomepageController>();

  CmsSectionResponse sectionsData = CmsSectionResponse();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var idleText = 'Pull down to refresh';
  List<SliverToBoxAdapter> sortedSections = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    LocalizationService().getLocalizationListFromServer();
    sectionsData = CmsSectionResponse.fromJson(kHomeMaps);
    formatData(sectionsData);
  }

  formatData(CmsSectionResponse? result) {
    sortedSections = [];
    for (var nameSorting in sectionNamesSorting) {
      result?.sections?.nodes?.forEach((element) {
        if (element.name == nameSorting.name && (element.enabled ?? true)) {
          sortedSections.add(SliverToBoxAdapter(
            child: HomeSection(
              section: element,
              direction: nameSorting.direction,
              showSectionTitle: nameSorting.showSectionTitle,
              hideShopButton: nameSorting.hideShopButton,
              pageTextAlign: nameSorting.pageTextAlign,
            ),
          ));
        }
      });
    }
  }

  goToProductListPage() {
    Get.toNamed(AppRouters.productList);
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
