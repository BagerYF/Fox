class SearchHistoryModel {
  String? name;

  SearchHistoryModel({this.name});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  SearchHistoryModel.fromName(String n) {
    name = n;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
