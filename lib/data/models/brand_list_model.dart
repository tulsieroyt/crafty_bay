import 'package:crafty_bay/data/models/banner/brand_model.dart';

class BrandListModel {
  String? msg;
  List<BrandModel>? brandList;

  BrandListModel({this.msg, this.brandList});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      brandList = <BrandModel>[];
      json['data'].forEach((v) {
        brandList!.add(BrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (brandList != null) {
      data['data'] = brandList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}