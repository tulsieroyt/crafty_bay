
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> createReview(
      int productId, String description, int rating) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "description": description,
      "product_id": productId,
      "rating": rating
    };
    final response = await NetworkCaller().postRequest(Urls.createReview,
        body: inputParams, token: AuthController.token);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
