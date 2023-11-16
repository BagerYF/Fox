import 'package:fox/data/model/cart/cart_model.dart';
import 'package:fox/data/model/region/region_map.dart';

class Checkout {
  String? id;
  String? webUrl;
  AvailableShippingRates? availableShippingRates;
  ShippingRates? shippingLine;
  Amount? subtotalPriceV2;
  Amount? totalPriceV2;
  Amount? totalTaxV2;
  Amount? paymentDueV2;
  Amount? lineItemsSubtotalPrice;
  bool? taxExempt;
  bool? taxesIncluded;
  String? currencyCode;
  String? currencySymbol;

  Checkout({
    this.id,
    this.webUrl,
    this.availableShippingRates,
    this.shippingLine,
    this.subtotalPriceV2,
    this.totalPriceV2,
    this.totalTaxV2,
    this.paymentDueV2,
    this.lineItemsSubtotalPrice,
    this.taxExempt,
    this.taxesIncluded,
    this.currencyCode,
    this.currencySymbol,
  });

  Checkout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webUrl = json['webUrl'];
    availableShippingRates = json['availableShippingRates'] != null
        ? AvailableShippingRates.fromJson(json['availableShippingRates'])
        : null;
    shippingLine = json['shippingLine'] != null
        ? ShippingRates.fromJson(json['shippingLine'])
        : null;
    subtotalPriceV2 = json['subtotalPriceV2'] != null
        ? Amount.fromJson(json['subtotalPriceV2'])
        : null;
    totalPriceV2 = json['totalPriceV2'] != null
        ? Amount.fromJson(json['totalPriceV2'])
        : null;
    totalTaxV2 =
        json['totalTaxV2'] != null ? Amount.fromJson(json['totalTaxV2']) : null;
    paymentDueV2 = json['paymentDueV2'] != null
        ? Amount.fromJson(json['paymentDueV2'])
        : null;
    lineItemsSubtotalPrice = json['lineItemsSubtotalPrice'] != null
        ? Amount.fromJson(json['lineItemsSubtotalPrice'])
        : null;
    taxExempt = json['taxExempt'] ?? false;
    taxesIncluded = json['taxesIncluded'] ?? false;
    currencyCode = json['currencyCode'];
    var tempCurrencys = kRegionMaps
        .where((element) => element['currencyCode'] == currencyCode)
        .toList();
    if (tempCurrencys.isNotEmpty) {
      currencySymbol = tempCurrencys.first['symbol'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['webUrl'] = webUrl;
    if (availableShippingRates != null) {
      data['availableShippingRates'] = availableShippingRates!.toJson();
    }
    if (shippingLine != null) {
      data['shippingLine'] = shippingLine!.toJson();
    }
    if (subtotalPriceV2 != null) {
      data['subtotalPriceV2'] = subtotalPriceV2!.toJson();
    }
    if (totalPriceV2 != null) {
      data['totalPriceV2'] = totalPriceV2!.toJson();
    }
    if (totalTaxV2 != null) {
      data['totalTaxV2'] = totalTaxV2!.toJson();
    }
    if (paymentDueV2 != null) {
      data['paymentDueV2'] = paymentDueV2!.toJson();
    }
    if (lineItemsSubtotalPrice != null) {
      data['lineItemsSubtotalPrice'] = lineItemsSubtotalPrice!.toJson();
    }
    if (taxExempt != null) {
      data['taxExempt'] = taxExempt;
    }
    if (taxesIncluded != null) {
      data['taxesIncluded'] = taxesIncluded;
    }
    data['currencyCode'] = currencyCode;
    return data;
  }
}

class AvailableShippingRates {
  bool? ready;
  List<ShippingRates>? shippingRates;

  AvailableShippingRates({this.ready, this.shippingRates});

  AvailableShippingRates.fromJson(Map<String, dynamic> json) {
    ready = json['ready'];
    if (json['shippingRates'] != null) {
      shippingRates = <ShippingRates>[];
      json['shippingRates'].forEach((v) {
        shippingRates!.add(ShippingRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ready'] = ready;
    if (shippingRates != null) {
      data['shippingRates'] = shippingRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingRates {
  String? handle;
  Amount? priceV2;
  String? title;

  ShippingRates({this.handle, this.priceV2, this.title});

  ShippingRates.fromJson(Map<String, dynamic> json) {
    handle = json['handle'];
    priceV2 = json['priceV2'] != null ? Amount.fromJson(json['priceV2']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['handle'] = handle;
    if (priceV2 != null) {
      data['priceV2'] = priceV2!.toJson();
    }
    data['title'] = title;
    return data;
  }
}

class GiftDiscountModel {
  String? id;
  String? code;

  GiftDiscountModel({this.id, this.code});

  GiftDiscountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    return data;
  }
}
