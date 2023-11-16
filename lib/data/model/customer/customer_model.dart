import 'package:fox/data/model/address/model/address_model.dart';
import 'package:fox/data/model/order/order_model.dart';

class CustomerModel {
  String? id;
  bool? acceptsMarketing;
  String? displayName;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<AddressModel>? address;
  List<OrderModel>? orders;

  CustomerModel({
    this.id,
    this.acceptsMarketing,
    this.displayName,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.orders,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptsMarketing = json['acceptsMarketing'];
    displayName = json['displayName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    if (json['addresses'] != null && json['addresses']['edges'] != null) {
      address = <AddressModel>[];
      json['addresses']['edges'].forEach((v) {
        address!.add(AddressModel.fromJson(v['node']));
      });
    }
    if (json['orders'] != null && json['orders']['edges'] != null) {
      orders = <OrderModel>[];
      json['orders']['edges'].forEach((v) {
        orders!.add(OrderModel.fromJson(v['node']));
      });
    }
  }

  CustomerModel.fromLocalJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptsMarketing = json['acceptsMarketing'];
    displayName = json['displayName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['acceptsMarketing'] = acceptsMarketing;
    data['displayName'] = displayName;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    if (address != null) {
      data['address'] = address!.map((e) => e.toJson()).toList();
    }
    if (orders != null) {
      data['orders'] = orders!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
