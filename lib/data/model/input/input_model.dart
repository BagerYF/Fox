import 'package:flutter/material.dart';

class InputItemModel {
  String? name;
  TextEditingController? controller;
  bool? optional;
  TextStyle? titleTextStyle;
  bool? showTitle;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? lineColor;
  Color? errorLineColor;
  Function()? onTap;
  Function(String text)? onChange;
  Function(String text)? onSubmit;
  GlobalKey? key;
  bool? show;
  String? placeorderName;
  int? lines;
  bool? invalidEmail;
  String? errorMsg;
  bool? isEmpty;
  bool? autoFocus;
  bool? obscure;
  AutovalidateMode? autovalidateMode;

  late bool keyboardIsNum;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  FocusNode? focusNode;
  late bool forceInvalidate;
  int? maxLength;

  InputItemModel({
    this.name,
    this.controller,
    this.optional,
    this.titleTextStyle,
    this.showTitle,
    this.suffixIcon,
    this.prefixIcon,
    this.lineColor,
    this.errorLineColor,
    this.onTap,
    this.onChange,
    this.onSubmit,
    this.key,
    this.show,
    this.forceInvalidate = false,
    this.keyboardIsNum = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.placeorderName,
    this.lines,
    this.invalidEmail,
    this.maxLength,
    this.errorMsg = 'Required',
    this.isEmpty,
    this.autoFocus,
    this.obscure,
    this.autovalidateMode,
  });

  InputItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['placeorderName'] != null) {
      placeorderName = json['placeorderName'];
    } else {
      placeorderName = name;
    }
    controller = json['controller'];
    if (json['optional'] != null) {
      optional = json['optional'];
    }
    if (json['titleTextStyle'] != null) {
      titleTextStyle = json['titleTextStyle'];
    }
    if (json['showTitle'] != null) {
      showTitle = json['showTitle'];
    }
    if (json['suffixIcon'] != null) {
      suffixIcon = json['suffixIcon'];
    }
    if (json['prefixIcon'] != null) {
      prefixIcon = json['prefixIcon'];
    }
    if (json['lineColor'] != null) {
      lineColor = json['lineColor'];
    }
    if (json['errorLineColor'] != null) {
      errorLineColor = json['errorLineColor'];
    }
    if (json['onTap'] != null) {
      onTap = json['onTap'];
    }
    if (json['onChange'] != null) {
      onChange = json['onChange'];
    }
    if (json['onSubmit'] != null) {
      onSubmit = json['onSubmit'];
    }
    if (json['key'] != null) {
      key = json['key'];
    }
    if (json['lines'] != null) {
      lines = json['lines'];
    } else {
      lines = 1;
    }
    if (json['invalidEmail'] != null) {
      invalidEmail = json['invalidEmail'];
    } else {
      invalidEmail = false;
    }
    if (json['errorMsg'] != null) {
      errorMsg = json['errorMsg'];
    } else {
      errorMsg = 'Required';
    }
    if (json['isEmpty'] != null) {
      isEmpty = json['isEmpty'];
    } else {
      isEmpty = false;
    }
    if (json['autoFocus'] != null) {
      autoFocus = json['autoFocus'];
    } else {
      autoFocus = false;
    }
    if (json['obscure'] != null) {
      obscure = json['obscure'];
    } else {
      obscure = false;
    }
    if (json['autovalidateMode'] != null) {
      autovalidateMode = json['autovalidateMode'];
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
    }
    show = json['show'];
    forceInvalidate = json['forceInvalidate'] ?? false;
    keyboardIsNum = json['keyboardIsNum'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
