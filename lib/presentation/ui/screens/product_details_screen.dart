import 'dart:developer';

import 'package:crafty_bay/data/models/product/product_details_data.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list/add_to_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/review/review_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/color_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> noOfItems = ValueNotifier(1);
  List<Color> colors = [
    Colors.purple,
    Colors.black,
    Colors.amber,
    Colors.red,
    Colors.lightGreen,
  ];

  List<String> sizes = [
    'S',
    'L',
    'M',
    'XL',
    'XXL',
    'XXXL',
  ];

  Color? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    log(AuthController.token.toString());
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageCarousel(
                      urls: [
                        productDetailsController.productDetails.img1 ?? '',
                        productDetailsController.productDetails.img2 ?? '',
                        productDetailsController.productDetails.img3 ?? '',
                        productDetailsController.productDetails.img4 ?? '',
                      ],
                    ),
                    productDetailsBody(productDetailsController.productDetails),
                  ],
                ),
              ),
            ),
            priceAndAddToCartSection(productDetailsController.totalPrice)
          ],
        );
      }),
    );
  }

  Padding productDetailsBody(ProductDetailsData productDetails) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: noOfItems,
                  builder: (context, value, _) {
                    return ItemCount(
                      initialValue: value,
                      minValue: 1,
                      maxValue: 20,
                      decimalPlaces: 0,
                      step: 1,
                      color: AppColors.primaryColor,
                      onChanged: (v) {
                        noOfItems.value = v.toInt();
                        Get.find<ProductDetailsController>()
                            .updateQuantity(widget.productId, noOfItems.value);
                      },
                    );
                  }),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          reviewAndRatingRow(
              productDetails.product?.star ?? 0, widget.productId),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Color',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          ColorSelector(
            colors: productDetails.color
                    ?.split(',')
                    .map((e) => getColorFromString(e))
                    .toList() ??
                [],
            onChange: (selectedColor) {
              _selectedColor = selectedColor;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Size',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          SizeSelector(
              sizes: productDetails.size?.split(',') ?? [],
              onChange: (s) {
                _selectedSize = s;
              }),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            productDetails.des ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Row reviewAndRatingRow(int rating, int productId) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 18,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              rating.toStringAsPrecision(2),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => ReviewScreen(productId: productId));
          },
          child: const Text(
            'Reviews',
            style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        GetBuilder<AddToWishListController>(builder: (addToWishListController) {
          return GestureDetector(
            onTap: () async {
              final result =
                  await addToWishListController.addToWishList(productId);
              if (result) {
                Get.showSnackbar(const GetSnackBar(
                  title: 'Success',
                  message: 'Your product successfully added to wishlist',
                  duration: Duration(seconds: 2),
                ));
              } else {
                Get.showSnackbar(GetSnackBar(
                  title: 'Failed',
                  message: addToWishListController.errorMessage,
                  duration: const Duration(seconds: 2),
                ));
              }
            },
            child: Card(
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.favorite_outline_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          );
        })
      ],
    );
  }

  Container priceAndAddToCartSection(RxDouble totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
              Obx(
                () => Text(
                  '$totalPrice',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child:
                GetBuilder<AddToCartController>(builder: (addToCartController) {
              return Visibility(
                visible: addToCartController.inProgress == false,
                replacement: const CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedColor != null && _selectedSize != null) {
                      if (Get.find<AuthController>().isTokenNotNull) {
                        final stringColor = colorToString(_selectedColor!);
                        final response = await addToCartController.addToCart(
                          widget.productId,
                          stringColor,
                          _selectedSize!,
                          noOfItems.value,
                        );
                        if (response) {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'Success',
                            message: 'This product has been added to cart',
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          Get.showSnackbar(GetSnackBar(
                            title: 'Add to cart failed',
                            message: addToCartController.errorMessage,
                            duration: const Duration(seconds: 2),
                          ));
                        }
                      } else {
                        Get.to(() => const VerifyEmailScreen());
                      }
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Add to cart failed',
                        message: 'Please select color and size',
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: const Text('Add to Cart'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Color getColorFromString(String color) {
    color = color.toLowerCase();
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'white') {
      return Colors.white;
    } else if (color == 'green') {
      return Colors.green;
    }
    return Colors.grey;
  }

  String colorToString(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.white) {
      return 'White';
    } else if (color == Colors.green) {
      return 'Green';
    }
    return 'Grey';
  }
}
