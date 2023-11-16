import 'package:azlistview/azlistview.dart';

class DesignerModel with ISuspensionBean {
  String? name;
  String? tagIndex;
  bool? selected;

  DesignerModel({this.name, this.tagIndex, this.selected});

  DesignerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  DesignerModel.fromName(String n) {
    name = n;
  }

  DesignerModel.fromNameSelect(String n) {
    name = n;
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }

  @override
  String getSuspensionTag() {
    return tagIndex!;
  }
}
