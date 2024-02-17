import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list/cart_list_controller.dart';
import 'package:get/get.dart';

class DeleteCartController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> deleteFromCart(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.deleteFromCartList(productId));
    if (response.isSuccess) {
      isSuccess = true;
      //TODO - Is this correct or not:
      Get.find<CartListController>().getCartList();
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
