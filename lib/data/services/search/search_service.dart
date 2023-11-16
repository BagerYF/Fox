import 'package:fox/data/model/search/model/search_model.dart';
import 'package:fox/utils/tools/local_storage/local_storage.dart';

class SearchService {
  // ignore: constant_identifier_names
  static const SEARCHHISTORY = 'search_history';

  Future<List<SearchHistoryModel>> getSearchHistoryList() async {
    var designers = await LocalStorage().getStorage(SEARCHHISTORY) ?? [];
    designers = designers
        .map<SearchHistoryModel>((e) => SearchHistoryModel.fromName(e))
        .toList();
    if (designers.length > 5) {
      designers = designers.take(5).toList();
    }
    return designers;
  }

  setSearchHistory(String search) async {
    List localDesigners = await LocalStorage().getStorage(SEARCHHISTORY) ?? [];
    List<String> designers = localDesigners.map((e) => e as String).toList();
    designers.insert(0, search);
    if (designers.isNotEmpty) {
      designers = designers.toSet().toList();
      if (designers.length > 10) {
        designers = designers.take(10).toList();
      }
    }
    await LocalStorage().setStringList(SEARCHHISTORY, designers);
  }

  removeSearchHistoryList() {
    LocalStorage().removeStorage(SEARCHHISTORY);
  }
}
