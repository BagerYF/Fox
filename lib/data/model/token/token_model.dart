class TokenModel {
  String? accessToken;
  String? expiresAt;

  TokenModel({this.accessToken, this.expiresAt});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['expiresAt'] = expiresAt;
    return data;
  }
}
