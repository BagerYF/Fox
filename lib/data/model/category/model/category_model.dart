class CategoryModel {
  String? name;
  bool? selected;
  List<CategoryModel>? children;

  CategoryModel({this.name, this.children, this.selected});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['children'] != null) {
      children = <CategoryModel>[];
      json['children'].forEach((v) {
        children?.add(CategoryModel.fromJson(v));
      });
    }
  }

  CategoryModel.fromNameSelect(String n) {
    name = n;
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (children != null) {
      data['children'] = children?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
