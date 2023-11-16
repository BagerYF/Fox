import 'package:fox/config/config.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/product/model/product_model.dart';
import 'package:fox/data/model/product/model/sort_model.dart';
import 'package:fox/data/model/product/sort_map.dart';
import 'package:fox/data/services/product/product_service.dart';

class ProductListPageController extends GetxController {
  int sortIndex = 0;
  late SortModel sort;
  List<SortModel> sortList = [];
  List<Product> productList = [];
  List<Filters> allFilters = [];
  String subFiltersName = '';
  List<SubFilters> subFilters = [];
  RefreshController refreshController = RefreshController(initialRefresh: true);
  Map<String, dynamic> requestParmas = {};
  PageInfo? pageInfo;
  var first = 30;
  List<Map<String, dynamic>> currentFilters = [];
  var query = Get.arguments?['query'] ?? '';

  @override
  void onInit() {
    super.onInit();

    initData();
  }

  initData() {
    sortList = kSortMap.map((e) => SortModel.fromJson(e)).toList();
    sort = sortList.first;
  }

  onRefresh({LoadingType loadingType = LoadingType.none}) async {
    refreshController.resetNoData();
    requestParmas = {
      "first": first,
      "id": EnvironmentConfig.collectionGid,
      "filters": currentFilters,
      "reverse": sort.reverse,
      "sortKey": sort.sortKey,
      "query": query,
    };

    ProductList result = await ProductService()
        .getProductList(requestParmas, loadingType: loadingType);
    productList = [];
    var tempList = result.value ?? [];
    productList.addAll(tempList);
    pageInfo = result.pageInfo;
    initFilters(result.filters ?? []);
    update();

    refreshController.refreshCompleted();
  }

  onLoading() async {
    requestParmas = {
      "first": first,
      "after": pageInfo?.endCursor,
      "id": EnvironmentConfig.collectionGid,
      "filters": currentFilters,
      "reverse": sort.reverse,
      "sortKey": sort.sortKey,
      "query": query,
    };

    ProductList result = await ProductService().getProductList(requestParmas);
    var tempList = result.value ?? [];
    productList.addAll(tempList);
    pageInfo = result.pageInfo;
    update();

    refreshController.loadComplete();

    if (pageInfo?.hasNextPage == false) {
      refreshController.loadNoData();
    }
  }

  List<String> get sortTypeList {
    List<String> pickOneViewList = sortList.map((e) => e.name!).toList();
    return pickOneViewList;
  }

  sortProduct(index) async {
    sort = sortList[index];
    sortIndex = index;
    update();
    refreshController.requestRefresh();
  }

  initFilters(List<Filters> tempFilters) {
    if (allFilters.isEmpty) {
      allFilters = tempFilters;
      if (allFilters.isNotEmpty) {
        var tempSubFilters = allFilters.first;
        subFiltersName = tempSubFilters.label ?? '';
        tempSubFilters.selected = true;
        subFilters = tempSubFilters.values ?? [];
      }
    } else {
      allFilters = [];
      allFilters = tempFilters;
      if (allFilters.isNotEmpty) {
        for (var element in allFilters) {
          for (var e in element.values ?? []) {
            for (var f in currentFilters) {
              if (e.input.toString() == f.toString()) {
                e.selected = true;
              }
            }
          }
          if (subFiltersName == element.label) {
            element.selected = true;
            subFilters = element.values ?? [];
          }
        }
      }
    }
  }

  selectFilter(Filters tempFilters) {
    for (var element in allFilters) {
      if (element == tempFilters) {
        element.selected = true;
      } else {
        element.selected = false;
      }
    }
    subFiltersName = tempFilters.label ?? '';
    subFilters = tempFilters.values ?? [];
    update();
  }

  selectSubFilter(SubFilters tempSubFilters) {
    tempSubFilters.selected = !tempSubFilters.selected;
    if (tempSubFilters.selected) {
      currentFilters.add(tempSubFilters.input ?? {});
    } else {
      for (var element in currentFilters) {
        if (element.toString() == tempSubFilters.input.toString()) {
          currentFilters.remove(element);
          break;
        }
      }
    }
    onRefresh(loadingType: LoadingType.display);
    update();
  }

  clearFilter() {
    if (currentFilters.isNotEmpty) {
      for (var element in allFilters) {
        for (var e in element.values ?? []) {
          e.selected = false;
        }
      }
      currentFilters = [];
      onRefresh(loadingType: LoadingType.display);
      update();
    }
  }
}
