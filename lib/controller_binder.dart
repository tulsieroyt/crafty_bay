import 'package:crafty_bay/presentation/state_holders/auth/resend_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/brand_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list/delete_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/read_customer_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/invoice_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/privacy_policy/about_privecy_policy_controller.dart';
import 'package:crafty_bay/presentation/state_holders/privacy_policy/refund_privacy_policy_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review/create_review_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/add_to_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review/review_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/send_email_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/remove_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(SendEmailOtpController());
    Get.put(VerifyOTPController());
    Get.put(AuthController());
    Get.put(CompleteProfileController());
    Get.put(HomeBannerController());
    Get.put(CategoryController());
    Get.put(BrandController());
    Get.put(PopularProductController());
    Get.put(NewProductController());
    Get.put(SpecialProductController());
    Get.put(ProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(CartListController());
    Get.put(CreateInvoiceController());
    Get.put(ReviewController());
    Get.put(AddToWishListController());
    Get.put(WishListController());
    Get.put(DeleteCartController());
    Get.put(RemoveWishListController());
    Get.put(ReadCustomerProfileController());
    Get.put(CreateReviewController());
    Get.put(InvoiceListController());
    Get.put(AboutPrivacyPolicyController());
    Get.put(RefundPrivacyPolicyController());
    Get.put(ResendOtpController());
  }
}
