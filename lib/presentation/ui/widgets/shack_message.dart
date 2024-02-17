import 'package:get/get.dart';

class SnackMessage {
  static showMessage({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
