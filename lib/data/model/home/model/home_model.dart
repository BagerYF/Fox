class CmsSectionResponse {
  CmsSection? sections;

  CmsSectionResponse({this.sections});

  CmsSectionResponse.fromJson(Map<String, dynamic> json) {
    sections =
        json['sections'] != null ? CmsSection.fromJson(json['sections']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sections != null) {
      data['sections'] = sections!.toJson();
    }
    return data;
  }
}

class CmsSection {
  List<CmsSectionNode>? nodes;

  CmsSection({this.nodes});

  CmsSection.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <CmsSectionNode>[];
      json['nodes'].forEach((v) {
        nodes!.add(CmsSectionNode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nodes != null) {
      data['nodes'] = nodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CmsSectionNode {
  String? sId;
  bool? enabled;
  String? name;
  String? title;
  String? subTitle;
  String? link;
  Shop? shop;
  List<CmsSectionItemResponse>? items;

  CmsSectionNode(
      {this.sId,
      this.enabled,
      this.name,
      this.title,
      this.subTitle,
      this.link,
      this.shop,
      this.items});

  CmsSectionNode.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    enabled = json['enabled'];
    name = json['name'];
    title = json['title'];
    subTitle = json['subTitle'];
    link = json['link'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(CmsSectionItemResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['enabled'] = enabled;
    data['name'] = name;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['link'] = link;
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  String? sId;

  Shop({this.sId});

  Shop.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    return data;
  }
}

class CmsSectionItemResponse {
  String? image;
  String? mobileImage;
  String? text;
  String? url;
  String? absoluteImageUrl;
  String? absoluteMobileImageUrl;
  String? brand;
  String? productName;

  CmsSectionItemResponse(
      {this.image,
      this.mobileImage,
      this.text,
      this.url,
      this.absoluteImageUrl,
      this.absoluteMobileImageUrl,
      this.brand,
      this.productName});

  CmsSectionItemResponse.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    mobileImage = json['mobileImage'];
    text = json['text'];
    url = json['url'];
    absoluteImageUrl = json['absoluteImageUrl'] ??
        'https://img2.baidu.com/it/u=2716494774,2819221109&fm=253&fmt=auto&app=138&f=JPEG?w=499&h=299';
    absoluteMobileImageUrl = json['absoluteMobileImageUrl'];
    brand = json['brand'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['mobileImage'] = mobileImage;
    data['text'] = text;
    data['url'] = url;
    data['absoluteImageUrl'] = absoluteImageUrl;
    data['absoluteMobileImageUrl'] = absoluteMobileImageUrl;
    data['brand'] = brand;
    data['productName'] = productName;

    return data;
  }
}
