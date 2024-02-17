import 'package:crafty_bay/data/models/user/customer_data.dart';

class CustomerDataModel {
  String? msg;
  CustomerData? customerData;

  CustomerDataModel({this.msg, this.customerData});

  CustomerDataModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    customerData =
        json['data'] != null ? CustomerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (customerData != null) {
      data['data'] = customerData!.toJson();
    }
    return data;
  }
}
