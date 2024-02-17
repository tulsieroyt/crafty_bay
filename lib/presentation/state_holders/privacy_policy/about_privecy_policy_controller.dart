import 'package:crafty_bay/data/models/privacy_policy_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class AboutPrivacyPolicyController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  PrivacyPolicyModel _privacyPolicyModel = PrivacyPolicyModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  PrivacyPolicyModel get privacyPolicyModel => _privacyPolicyModel;

  Future<bool> getAboutPrivacyPolicyByType() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().specialGetRequest(Urls.policyByType('about'));
    if (response.isSuccess) {
      isSuccess = true;
      _privacyPolicyModel = PrivacyPolicyModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
