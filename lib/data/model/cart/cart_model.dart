class Cart {
  String? id;
  int? totalQuantity;
  String? createdAt;
  String? updatedAt;
  List<CartItem>? cartItems;
  List<Attributes>? attributes;
  Cost? cost;

  Cart(
      {this.id,
      this.totalQuantity,
      this.createdAt,
      this.updatedAt,
      this.cartItems,
      this.attributes,
      this.cost});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalQuantity = json['totalQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['lines'] != null && json['lines']['edges'] != null) {
      cartItems = <CartItem>[];
      json['lines']['edges'].forEach((v) {
        cartItems!.add(CartItem.fromJson(v['node']));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    cost = json['cost'] != null ? Cost.fromJson(json['cost']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalQuantity'] = totalQuantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((e) => e.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    if (cost != null) {
      data['cost'] = cost!.toJson();
    }
    return data;
  }
}

class CartItem {
  String? id;
  int? quantity;
  Cost? cost;
  Merchandise? merchandise;

  CartItem({this.id, this.quantity, this.cost, this.merchandise});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    cost = json['cost'] != null ? Cost.fromJson(json['cost']) : null;
    merchandise = json['merchandise'] != null
        ? Merchandise.fromJson(json['merchandise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    if (cost != null) {
      data['cost'] = cost!.toJson();
    }
    if (merchandise != null) {
      data['merchandise'] = merchandise!.toJson();
    }
    return data;
  }
}

class Merchandise {
  String? id;
  Amount? compareAtPrice;
  String? title;
  Amount? price;
  int? quantityAvailable;
  String? url;
  String? productTitle;
  String? vendor;
  String? productType;

  Merchandise(
      {this.id,
      this.compareAtPrice,
      this.title,
      this.price,
      this.quantityAvailable,
      this.url,
      this.productTitle,
      this.vendor,
      this.productType});

  Merchandise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantityAvailable = json['quantityAvailable'];
    url = json['image']['url'];
    productTitle = json['product']['title'];
    vendor = json['product']['vendor'];
    productType = json['product']['productType'];

    compareAtPrice = json['compareAtPrice'] != null
        ? Amount.fromJson(json['compareAtPrice'])
        : null;

    price = json['price'] != null ? Amount.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['compareAtPrice'] = compareAtPrice;
    data['title'] = title;
    data['price'] = price;
    data['quantityAvailable'] = quantityAvailable;
    data['url'] = url;
    data['productTitle'] = productTitle;
    data['vendor'] = vendor;
    data['productType'] = productType;
    return data;
  }
}

class Attributes {
  String? key;
  String? value;

  Attributes({this.key, this.value});

  Attributes.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class Cost {
  Amount? totalAmount;
  Amount? subtotalAmount;
  Amount? totalTaxAmount;
  String? totalDutyAmount;

  Cost(
      {this.totalAmount,
      this.subtotalAmount,
      this.totalTaxAmount,
      this.totalDutyAmount});

  Cost.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'] != null
        ? Amount.fromJson(json['totalAmount'])
        : null;
    subtotalAmount = json['subtotalAmount'] != null
        ? Amount.fromJson(json['subtotalAmount'])
        : null;
    totalTaxAmount = json['totalTaxAmount'] != null
        ? Amount.fromJson(json['totalTaxAmount'])
        : null;
    totalDutyAmount = json['totalDutyAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (totalAmount != null) {
      data['totalAmount'] = totalAmount!.toJson();
    }
    if (subtotalAmount != null) {
      data['subtotalAmount'] = subtotalAmount!.toJson();
    }
    if (totalTaxAmount != null) {
      data['totalTaxAmount'] = totalTaxAmount!.toJson();
    }
    data['totalDutyAmount'] = totalDutyAmount;
    return data;
  }
}

class Amount {
  String? amount;
  String? currencyCode;

  Amount({this.amount, this.currencyCode});

  Amount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currencyCode'] = currencyCode;
    return data;
  }
}
