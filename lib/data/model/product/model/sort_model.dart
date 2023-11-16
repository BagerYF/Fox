class SortModel {
  String? name;
  bool? reverse;
  String? sortKey;

  SortModel({this.name, this.reverse, this.sortKey});

  SortModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    reverse = json['reverse'];
    sortKey = json['sortKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['reverse'] = reverse;
    data['sortKey'] = sortKey;
    return data;
  }
}
