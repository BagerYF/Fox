class BlogList {
  List<BlogModel>? value;
  PageInfo? pageInfo;

  BlogList({this.value, this.pageInfo});

  BlogList.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      value = <BlogModel>[];
      json['edges'].forEach((v) {
        value!.add(BlogModel.fromJson(v['node']));
      });
    }
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['edges'] = value!.map((v) => v.toJson()).toList();
    }
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    return data;
  }
}

class BlogModel {
  String? id;
  String? handle;
  String? title;
  List<Authors>? authors;
  String? onlineStoreUrl;
  List<Articles>? articles;

  BlogModel(
      {this.id,
      this.handle,
      this.title,
      this.authors,
      this.onlineStoreUrl,
      this.articles});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handle = json['handle'];
    title = json['title'];
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(Authors.fromJson(v));
      });
    }
    onlineStoreUrl = json['onlineStoreUrl'];
    if (json['articles']['edges'] != null) {
      articles = <Articles>[];
      json['articles']['edges'].forEach((v) {
        articles!.add(Articles.fromJson(v['node']));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handle'] = handle;
    data['title'] = title;
    if (authors != null) {
      data['authors'] = authors!.map((v) => v.toJson()).toList();
    }
    data['onlineStoreUrl'] = onlineStoreUrl;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Authors {
  String? name;

  Authors({this.name});

  Authors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Articles {
  String? title;
  String? content;
  String? contentHtml;
  String? onlineStoreUrl;

  Articles({this.title, this.content, this.contentHtml});

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    contentHtml = json['contentHtml'];
    onlineStoreUrl = json['onlineStoreUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['contentHtml'] = contentHtml;
    data['onlineStoreUrl'] = onlineStoreUrl;
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
