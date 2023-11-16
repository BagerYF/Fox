class RegionModel {
  String? name;
  String? code;
  String? currencyCode;
  String? currency;
  String? regionCode;
  bool? isFreeReturn;

  RegionModel({
    this.name,
    this.code,
    this.currencyCode,
    this.currency,
    this.regionCode,
    this.isFreeReturn,
  });

  RegionModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    code = json["code"];
    currencyCode = json["currencyCode"];
    if (json["symbol"] != null) {
      currency = json["symbol"];
    }
    if (json["currency"] != null) {
      currency = json["currency"];
    }
    regionCode = json["regionCode"];
    isFreeReturn = json["isFreeReturn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["code"] = code;
    data["currencyCode"] = currencyCode;
    data["currency"] = currency;
    data['regionCode'] = regionCode;
    data['isFreeReturn'] = isFreeReturn;
    return data;
  }

  String formatRegion() {
    return '$name, $currencyCode $currency';
  }
}
