import 'dart:developer';
import 'package:crafty_bay/data/models/review/reviews.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Reviews _listOfReview = Reviews();

  Reviews get listOfReview => _listOfReview;

  Future<bool> getReviewList({required int categoryId}) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.reviewByProductId(categoryId));
    log('This is response');
    log(response.toString());
    log('response.responseDat ${response.responseData}');
    _inProgress = false;
    if (response.isSuccess) {
      _listOfReview = Reviews.fromJson(response.responseData);
      //log(_listOfReview.reviewData![1].id.toString());
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
