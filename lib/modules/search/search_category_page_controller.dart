import 'package:get/get.dart';
import 'package:fox/data/model/category/category_map.dart';
import 'package:fox/data/model/category/model/category_model.dart';

class SearchCategoryPageController extends GetxController {
  final params = Get.arguments as Map;
  late String department;
  late String tags;
  List<CategoryModel> categoryList = [];

  @override
  void onInit() {
    department = params['department'];
    tags = params['tags'];

    initData();

    super.onInit();
  }

  initData() async {
    categoryList = await _getCategoryList();
    update();
  }

  _getCategoryList() {
    var firstLevelCategory =
        kCategoryMaps.firstWhere((element) => element['name'] == department);
    var secondLevelCategory = firstLevelCategory['children']
        .firstWhere((element) => element['name'] == tags);

    return secondLevelCategory['children']
        .map<CategoryModel>((e) => CategoryModel.fromJson(e))
        .toList();
  }
}
