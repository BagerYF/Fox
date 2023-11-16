import 'dart:convert' as convert;

class ProductList {
  PageInfo? pageInfo;
  List<Product>? value;
  List<Filters>? filters;

  ProductList({
    this.pageInfo,
    this.value,
  });

  ProductList.fromJson(Map<String, dynamic> json) {
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;

    value = json['edges'] != null
        ? json['edges']
            .map<Product>((e) => Product.fromJson(e['node']))
            .toList()
        : [];

    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  String? endCursor;
  bool? hasNextPage;
  bool? hasPreviousPage;
  String? startCursor;

  PageInfo(
      {this.endCursor,
      this.hasNextPage,
      this.hasPreviousPage,
      this.startCursor});

  PageInfo.fromJson(Map<String, dynamic> json) {
    endCursor = json['endCursor'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
    startCursor = json['startCursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['endCursor'] = endCursor;
    data['hasNextPage'] = hasNextPage;
    data['hasPreviousPage'] = hasPreviousPage;
    data['startCursor'] = startCursor;
    return data;
  }
}

class Product {
  String? id;
  String? title;
  String? vendor;
  String? productType;
  String? handle;
  String? description;
  List<String>? images;
  List<Variant>? variants;

  Product(
      {this.id,
      this.title,
      this.vendor,
      this.productType,
      this.handle,
      this.description,
      this.images,
      this.variants});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vendor = json['vendor'];
    productType = json['productType'];
    handle = json['handle'];
    description = json['description'];
    if (json['images'] != null && json['images']['edges'] != null) {
      images = <String>[];
      json['images']['edges'].forEach((v) {
        images!.add(v['node']['url']);
      });
    }
    if (json['variants'] != null && json['variants']['edges'] != null) {
      variants = <Variant>[];
      json['variants']['edges'].forEach((v) {
        variants!.add(Variant.fromJson(v['node']));
      });
    }
  }

  Product.fromModelJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vendor = json['vendor'];
    productType = json['productType'];
    handle = json['handle'];
    description = json['description'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((i) {
        images!.add(i);
      });
    }
    if (json['variants'] != null) {
      variants = <Variant>[];
      json['variants'].forEach((v) {
        variants!.add(Variant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['vendor'] = vendor;
    data['productType'] = productType;
    data['handle'] = handle;
    data['description'] = description;
    if (images != null) {
      data['images'] = images;
    }
    if (variants != null) {
      data['variants'] = variants!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Variant {
  String? id;
  PriceV2? compareAtPrice;
  String? title;
  PriceV2? price;
  int? quantityAvailable;
  String? image;
  String? size;
  String? color;
  Product? product;
  PriceV2? priceV2;
  bool? isSoldOut;

  Variant({
    this.id,
    this.compareAtPrice,
    this.title,
    this.price,
    this.quantityAvailable,
    this.size,
    this.color,
    this.product,
    this.priceV2,
    this.isSoldOut,
  });

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantityAvailable = json['quantityAvailable'];
    if (quantityAvailable == 0) {
      isSoldOut = true;
    } else {
      isSoldOut = false;
    }
    if (json['image'] != null) {
      image = json['image']['url'];
    }
    if (json['product'] != null) {
      product = Product.fromJson(json['product']);
    }

    priceV2 =
        json['priceV2'] != null ? PriceV2.fromJson(json['priceV2']) : null;

    compareAtPrice = json['compareAtPrice'] != null
        ? PriceV2.fromJson(json['compareAtPrice'])
        : null;

    price = json['price'] != null ? PriceV2.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['compareAtPrice'] = compareAtPrice;
    data['title'] = title;
    data['price'] = price;
    data['quantityAvailable'] = quantityAvailable;
    if (image != null) {
      data['image'] = image;
    }
    if (priceV2 != null) {
      data['priceV2'] = priceV2!.toJson();
    }
    return data;
  }
}

class PriceV2 {
  String? amount;
  String? currencyCode;

  PriceV2({this.amount, this.currencyCode});

  PriceV2.fromJson(Map<String, dynamic> json) {
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

class Filters {
  String? id;
  String? label;
  String? type;
  List<SubFilters>? values;
  bool? selected;

  Filters({this.id, this.label, this.type, this.values});

  Filters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    type = json['type'];
    if (json['values'] != null) {
      values = <SubFilters>[];
      json['values'].forEach((v) {
        values!.add(SubFilters.fromJson(v));
      });

      if (label == 'Price' && values!.isNotEmpty) {
        var priceRange = values!.first.input;
        double min = priceRange?['price']['min'].toDouble();
        double max = priceRange?['price']['max'].toDouble();
        var nums = [100.0, 200.0, 500.0, 800.0, 1000.0, 2000.0, 5000.0, 10000.0]
            .where((element) => element >= min && element <= max)
            .toList();
        if (nums.first != min) {
          nums.insert(0, min);
        }
        if (nums.last != max) {
          nums.add(max);
        }
        values = [];
        for (var i = 0; i < nums.length; i++) {
          if (i < nums.length - 1) {
            values!.add(SubFilters.fromJson({
              "id": "filter.v.price",
              "input":
                  "{\"price\":{\"min\":${nums[i]},\"max\":${nums[i + 1]}}}",
              "label": "Price ¥(${nums[i]}-${nums[i + 1]})",
              "count": 0
            }));
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['type'] = type;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubFilters {
  String? id;
  Map<String, dynamic>? input;
  String? label;
  int? count;
  bool selected = false;

  SubFilters({this.id, this.input, this.label, this.count});

  SubFilters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    input = convert.jsonDecode(json['input']);
    label = json['label'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['input'] = input;
    data['label'] = label;
    data['count'] = count;
    return data;
  }
}
