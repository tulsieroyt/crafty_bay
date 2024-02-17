import 'dart:async';

import 'package:get/get.dart';

class ResendOtpController extends GetxController {
  final RxInt timeRemaining = 20.obs;

  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        _timer.cancel();
      }
    });
  }

  void resendOTP() {
    timeRemaining.value = 20;
    startTimer();
  }

  bool isResendable(){
    if(timeRemaining.value == 0){

    }
    return true;
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
