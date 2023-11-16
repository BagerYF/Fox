class LocalizationModel {
  String? name;
  Currency? currency;
  String? isoCode;
  String? unitSystem;
  List<AvailableLanguages>? availableLanguages;

  LocalizationModel(
      {this.name,
      this.currency,
      this.isoCode,
      this.unitSystem,
      this.availableLanguages});

  LocalizationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    isoCode = json['isoCode'];
    unitSystem = json['unitSystem'];
    if (json['availableLanguages'] != null) {
      availableLanguages = <AvailableLanguages>[];
      json['availableLanguages'].forEach((v) {
        availableLanguages!.add(AvailableLanguages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    data['isoCode'] = isoCode;
    data['unitSystem'] = unitSystem;
    if (availableLanguages != null) {
      data['availableLanguages'] =
          availableLanguages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currency {
  String? name;
  String? symbol;
  String? isoCode;

  Currency({this.name, this.symbol, this.isoCode});

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    isoCode = json['isoCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['symbol'] = symbol;
    data['isoCode'] = isoCode;
    return data;
  }
}

class AvailableLanguages {
  String? name;
  String? isoCode;
  String? endonymName;

  AvailableLanguages({this.name, this.isoCode, this.endonymName});

  AvailableLanguages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isoCode = json['isoCode'];
    endonymName = json['endonymName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isoCode'] = isoCode;
    data['endonymName'] = endonymName;
    return data;
  }
}
