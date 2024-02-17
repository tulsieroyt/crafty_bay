import 'package:crafty_bay/data/models/wish_list/wish_list_item.dart';

class WishListModel {
  String? msg;
  List<WishListData>? wishList;

  WishListModel({this.msg, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishList = <WishListData>[];
      json['data'].forEach((v) {
        wishList!.add(WishListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (wishList != null) {
      data['data'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
