import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:fox/data/model/designers/designers_map.dart';
import 'package:fox/data/model/designers/model/designer_model.dart';

class DesignersPageController extends GetxController {
  List<DesignerModel> designersList = [];

  @override
  void onInit() {
    designersList = _getDesignerList();
    super.onInit();
  }

  List<DesignerModel> _getDesignerList() {
    List<String> localList = kDesigersMaps.map((e) => e).toList();
    localList.sort();
    return localList.map((e) => DesignerModel.fromJson({"name": e})).toList();
  }
}
