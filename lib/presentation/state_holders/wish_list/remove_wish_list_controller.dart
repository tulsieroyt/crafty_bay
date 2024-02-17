import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:get/get.dart';

class RemoveWishListController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> removeFromWishListById(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller()
        .getRequest(Urls.removeFromWishListById(productId));
    if (response.isSuccess) {
      isSuccess = true;
      Get.find<WishListController>().getWishList();
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
