import 'package:graphql/client.dart';
import 'package:fox/data/api/graphql_client.dart';
import 'package:fox/data/api/schema/address_schema.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/localization/localization_model.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class LocalizationService {
  // ignore: constant_identifier_names
  static const Localization = 'localization_list';

  Future<List<LocalizationModel>> getLocalizationList() async {
    var localizationList = await LocalStorage().getStorage(Localization);
    localizationList ??= await getLocalizationListFromServer();
    localizationList = localizationList
        .map<LocalizationModel>((e) => LocalizationModel.fromJson(e))
        .toList();
    return localizationList;
  }

  setLocalizationList(List localizationList) async {
    await LocalStorage().setObject(Localization, localizationList);
  }

  removeLocalizationList() {
    LocalStorage().removeStorage(Localization);
  }

  getLocalizationListFromServer() async {
    QueryResult response = await GQLProvider().client.query(
          schema: AddressSchema.getLocalizationList,
          loadingType: LoadingType.none,
          ignoreError: true,
        );
    var localizationList = response.data!['localization']['availableCountries'];
    setLocalizationList(localizationList);
    return localizationList;
  }
}
