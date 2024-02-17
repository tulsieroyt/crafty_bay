import 'package:crafty_bay/data/models/product/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/add_to_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/remove_wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/shack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key,
    required this.product,
    required this.isWishListScreen,
  });

  final ProductModel product;

  final bool isWishListScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsScreen(
              productId: product.id!,
            ));
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 195,
        width: 160,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  product.image ?? '',
                  width: 160,
                  height: 120,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      children: [
                        Text(
                          '৳${product.price ?? 0}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            Text(
                              '${product.star ?? 0}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Card(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: isWishListScreen
                                ? GestureDetector(
                                    onTap: () async {
                                      final result = await Get.find<
                                              RemoveWishListController>()
                                          .removeFromWishListById(product.id!);
                                      if (result) {
                                        SnackMessage.showMessage(
                                            title: 'Success',
                                            message:
                                                'This product remove from wishlist');
                                      } else {
                                        SnackMessage.showMessage(
                                            title: 'Failed',
                                            message: Get.find<
                                                    RemoveWishListController>()
                                                .errorMessage);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete_forever,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      final result = await Get.find<
                                              AddToWishListController>()
                                          .addToWishList(product.id!);
                                      if (result) {
                                        SnackMessage.showMessage(
                                            title: 'Success',
                                            message:
                                                'This product add to your wishlist');
                                      } else {
                                        SnackMessage.showMessage(
                                            title: 'Failed',
                                            message: Get.find<
                                                    AddToWishListController>()
                                                .errorMessage);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
