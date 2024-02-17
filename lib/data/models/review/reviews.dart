import 'package:crafty_bay/data/models/review/review_data.dart';
class Reviews {
  String? msg;
  List<ReviewData>? reviewData;

  Reviews({this.msg, this.reviewData});

  Reviews.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewData = <ReviewData>[];
      json['data'].forEach((v) {
        reviewData!.add(ReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reviewData != null) {
      data['data'] = reviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

