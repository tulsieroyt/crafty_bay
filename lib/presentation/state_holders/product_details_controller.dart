import 'package:crafty_bay/data/models/product/product_details_data.dart';
import 'package:crafty_bay/data/models/product/product_details_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();

  ProductDetailsModel get productDetailsData => _productDetailsModel;

  final RxDouble _totalPrice = 0.0.obs;

  String _errorMessage = '';

  bool get inProgress => _inProgress;

  ProductDetailsData get productDetails =>
      _productDetailsModel.productDetailsDataList!.first;

  RxDouble get totalPrice => _totalPrice;

  String get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response =
        await NetworkCaller().getRequest(Urls.productDetails(productId));
    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.responseData);
      _totalPrice.value = _calculateTotalPrice;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  void updateQuantity(int id, int quantity) {
    productDetails.quantity = quantity;
    _totalPrice.value = _calculateTotalPrice;
  }

  double get _calculateTotalPrice {
    double total = 0;
    total += (double.tryParse(productDetails.product?.price ?? '0') ?? 0) *
        productDetails.quantity;
    return total;
  }
}
