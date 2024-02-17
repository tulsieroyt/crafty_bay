import 'package:crafty_bay/presentation/state_holders/cart_list/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/checkout_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/carts/cart_product_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/shack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.offAll(const MainBottomNavScreen());
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carts'),
          leading: IconButton(
            onPressed: () {
              Get.offAll(const MainBottomNavScreen());
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<CartListController>(builder: (cartListController) {
          if (cartListController.inProgress == true) {
            return const CenterCircularProgressIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: cartListController.cartListModel.cartItemList?.isEmpty ??
                        true
                    ? const Center(
                        child: Text('No Products in cart'),
                      )
                    : ListView.separated(
                        itemCount: cartListController
                                .cartListModel.cartItemList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProductDetailsScreen(
                                    productId: cartListController.cartListModel
                                        .cartItemList![index].productId!),
                              );
                            },
                            child: CartProductItem(
                              cartItem: cartListController
                                  .cartListModel.cartItemList![index],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 8,
                        ),
                      ),
              ),
              totalPriceAndCheckOutSection(cartListController.totalPrice)
            ],
          );
        }),
      ),
    );
  }

  Container totalPriceAndCheckOutSection(RxDouble totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.15),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              Obx(() => Text(
                    '৳$totalPrice',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  )),
            ],
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                //TODO- If you don't at least one product you cannot checkout --> Done
                if (Get.find<CartListController>()
                    .cartListModel
                    .cartItemList!
                    .isNotEmpty) {
                  Get.to(() => const CheckoutScreen());
                } else {
                  SnackMessage.showMessage(
                      title: 'Failed',
                      message: 'You have to cart a least one item');
                }
              },
              child: const Text('Check out'),
            ),
          ),
        ],
      ),
    );
  }
}
