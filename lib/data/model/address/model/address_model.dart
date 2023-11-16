class AddressModel {
  String? id;
  String? email;
  String? country;
  String? countryCodeV2;
  String? province;
  String? provinceCode;
  String? firstName;
  String? lastName;
  String? address1;
  String? city;
  String? zip;
  String? phone;
  String? address2;
  bool? rememberAddress;
  String? name;
  String? shopId;

  bool selected = false;
  bool billSelected = false;

  bool isBillingDefault = false;
  bool isCommercial = false;
  bool isShippingDefault = false;

  AddressModel({
    this.id,
    this.email,
    this.country,
    this.countryCodeV2,
    this.province,
    this.provinceCode,
    this.firstName,
    this.lastName,
    this.address1,
    this.city,
    this.zip,
    this.phone,
    this.address2,
    this.rememberAddress,
    this.name,
    this.shopId,
    this.isBillingDefault = false,
    this.isCommercial = false,
    this.isShippingDefault = false,
    this.selected = false,
    this.billSelected = false,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCodeV2 = json['countryCode'];
    province = json['province'];
    provinceCode = json['provinceCode'];
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    address1 = json['address1'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '';
    phone = json['phone'] ?? '';
    address2 = json['address2'] ?? '';
    rememberAddress = json['rememberAddress'];
    name = json['name'] ?? '';
    isBillingDefault = json['isBillingDefault'] ?? false;
    isCommercial = json['isCommercial'] ?? false;
    isShippingDefault = json['isShippingDefault'] ?? false;
    selected = json['selected'] ?? false;
    if (json['email'] != null) {
      email = json['email'];
    }
    if (json['id'] != null) {
      id = json['id'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['province'] = province;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['address1'] = address1;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['address2'] = address2;

    if (email != null) {
      data['email'] = email;
    }
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  String toEqualJson() {
    var str =
        '${country ?? ''}${countryCodeV2 ?? ''}${province ?? ''}${provinceCode ?? ''}${firstName ?? ''}${lastName ?? ''}${address1 ?? ''}${city ?? ''}${zip ?? ''}${phone ?? ''}${address2 ?? ''}${name ?? ''}';
    return str;
  }
}

class Country {
  String? code;
  String? name;
  String? currencyCode;
  num? taxRate;
  bool? priceIncludeTax;
  bool? selected;
  List<Provinces>? provinces;

  Country({this.code, this.name, this.provinces});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    currencyCode = json['currencyCode'];
    taxRate = json['taxRate'];
    priceIncludeTax = json['priceIncludeTax'];
    if (json['provinces'] != null) {
      provinces = [];
      json['provinces'].forEach((v) {
        provinces!.add(Provinces.fromJson(v));
      });
    }
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['currencyCode'] = currencyCode;
    data['taxRate'] = taxRate;
    data['priceIncludeTax'] = priceIncludeTax;
    if (provinces != null) {
      data['provinces'] = provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinces {
  String? code;
  String? name;
  bool? selected;

  Provinces({this.code, this.name});

  Provinces.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
