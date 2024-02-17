import 'dart:developer';

import 'package:crafty_bay/data/models/user/customer_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadCustomerProfileController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CustomerData _customerProfile = CustomerData();

  CustomerData get customerProfile => _customerProfile;

  bool _isProfileCompleted = false;

  bool get isProfileCompleted => _isProfileCompleted;

  Future<bool> readCustomerData(String token) async {
    log('Token is: $token');
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.readProfile, token: token);
    _inProgress = false;
    if (response.isSuccess) {
      final profileData = response.responseData['data'];
      if (profileData == null) {
        _isProfileCompleted = false;
      } else {
        _customerProfile = CustomerData.fromJson(profileData);
        _isProfileCompleted = true;
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
