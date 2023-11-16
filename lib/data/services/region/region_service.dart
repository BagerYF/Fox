import 'package:fox/data/model/region/model/region_model.dart';
import 'package:fox/data/model/region/region_map.dart';
import 'package:fox/modules/profile/profile_page_controller.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class RegionService {
  // ignore: constant_identifier_names
  static const Region = 'region_list';

  Future<List<RegionModel>> getRegionList() async {
    var regionList = await LocalStorage().getStorage(Region) ?? kRegionMaps;
    regionList =
        regionList.map<RegionModel>((e) => RegionModel.fromJson(e)).toList();
    return regionList;
  }

  setRegionList(List regionList) async {
    await LocalStorage().setObject(Region, regionList);

    var localRegionList = await getRegionList();
    var localRegion = ProfilePageController.to.region;
    for (var item in localRegionList) {
      if (item.code == localRegion.code) {
        if (item.toJson().toString() != localRegion.toJson().toString()) {
          await ProfilePageController.to.setCurrentRegion(item);
        }
        return;
      }
    }
  }

  removeRegionList() {
    LocalStorage().removeStorage(Region);
  }

  getRegionListFromServer() async {}
}
