import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/read_customer_profile_controller.dart';
import 'package:get/get.dart';

class VerifyOTPController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  bool _shouldNavigateCompleteProfile = true;

  bool get shouldNavigateCompleteProfile => _shouldNavigateCompleteProfile;

  String _token = '';

  String get token => _token;

  Future<bool> verifyOTP(String email, String otp) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    _inProgress = false;
    if (response.isSuccess) {
      _token = response.responseData['data'];
      final result = await Get.find<ReadCustomerProfileController>()
          .readCustomerData(token);
      if (result) {
        _shouldNavigateCompleteProfile =
            Get.find<ReadCustomerProfileController>().isProfileCompleted ==
                false;
        if (_shouldNavigateCompleteProfile == false) {
          await Get.find<AuthController>().saveUserDetails(
              token, Get.find<ReadCustomerProfileController>().customerProfile);
        }
      } else {
        _errorMessage = Get.find<ReadCustomerProfileController>().errorMessage;
        update();
        return false;
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }


}
