import 'package:fox/data/model/enum/enum.dart';

class ExceptionModel {
  ExceptionType? type;
  String? message;

  ExceptionModel({this.type, this.message});

  ExceptionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }

  @override
  String toString() {
    return message ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    return data;
  }
}
