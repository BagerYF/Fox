import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/cart/cart_model.dart';
import 'package:fox/data/model/product/model/product_model.dart';

class OrderModel {
  String? id;
  String? email;
  String? name;
  int? orderNumber;
  String? phone;
  AddressModel? shippingAddress;
  String? processedAt;
  List<LineItemsModel>? lineItems;
  Amount? subtotalPriceV2;
  Amount? totalPriceV2;
  Amount? totalTaxV2;
  Amount? totalShippingPriceV2;

  OrderModel({
    this.id,
    this.email,
    this.name,
    this.orderNumber,
    this.phone,
    this.shippingAddress,
    this.processedAt,
    this.lineItems,
    this.subtotalPriceV2,
    this.totalPriceV2,
    this.totalTaxV2,
    this.totalShippingPriceV2,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    orderNumber = json['orderNumber'];
    phone = json['phone'];
    if (json['shippingAddress'] != null) {
      shippingAddress = AddressModel.fromJson(json['shippingAddress']);
    }
    processedAt = json['processedAt'];
    if (json['lineItems'] != null && json['lineItems']['edges'] != null) {
      lineItems = <LineItemsModel>[];
      json['lineItems']['edges'].forEach((v) {
        lineItems!.add(LineItemsModel.fromJson(v['node']));
      });
    }
    subtotalPriceV2 = json['subtotalPriceV2'] != null
        ? Amount.fromJson(json['subtotalPriceV2'])
        : null;
    totalPriceV2 = json['totalPriceV2'] != null
        ? Amount.fromJson(json['totalPriceV2'])
        : null;
    totalTaxV2 =
        json['totalTaxV2'] != null ? Amount.fromJson(json['totalTaxV2']) : null;
    totalShippingPriceV2 = json['totalShippingPriceV2'] != null
        ? Amount.fromJson(json['totalShippingPriceV2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['orderNumber'] = orderNumber;
    data['phone'] = phone;
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['processedAt'] = processedAt;
    return data;
  }
}

class LineItemsModel {
  Variant? variant;
  String? title;
  int? quantity;
  Amount? originalTotalPrice;

  LineItemsModel({
    this.variant,
    this.title,
    this.quantity,
    this.originalTotalPrice,
  });

  LineItemsModel.fromJson(Map<String, dynamic> json) {
    variant = Variant.fromJson(json['variant']);
    title = json['title'];
    quantity = json['quantity'];
    if (json['originalTotalPrice'] != null) {
      originalTotalPrice = Amount.fromJson(json['originalTotalPrice']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variant'] = variant;
    data['title'] = title;
    data['quantity'] = quantity;
    if (originalTotalPrice != null) {
      data['originalTotalPrice'] = originalTotalPrice!.toJson();
    }
    return data;
  }
}
