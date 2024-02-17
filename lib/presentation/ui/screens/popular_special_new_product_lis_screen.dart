import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularSpecialNewProductListScreen extends StatefulWidget {
  const PopularSpecialNewProductListScreen({
    super.key,
    required this.remark,
  });

  final String remark;

  @override
  State<PopularSpecialNewProductListScreen> createState() =>
      _PopularSpecialNewProductListScreenState();
}

class _PopularSpecialNewProductListScreenState
    extends State<PopularSpecialNewProductListScreen> {
  final PopularProductController popularProductController =
      Get.find<PopularProductController>();
  final SpecialProductController specialProductController =
      Get.find<SpecialProductController>();
  final NewProductController newProductController =
      Get.find<NewProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.remark),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Visibility(
          visible: widget.remark == 'Popular'
              ? popularProductController.inProgress == false
              : widget.remark == 'Special'
                  ? specialProductController.inProgress == false
                  : newProductController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: Visibility(
            visible: widget.remark == 'Popular'
                ? popularProductController
                        .productListModel.productList?.isNotEmpty ??
                    false
                : widget.remark == 'Special'
                    ? specialProductController
                            .productListModel.productList?.isNotEmpty ??
                        false
                    : newProductController
                            .productListModel.productList?.isNotEmpty ??
                        false,
            replacement: const Center(
              child: Text('No products'),
            ),
            child: GridView.builder(
              itemCount: widget.remark == 'Popular'
                  ? popularProductController
                          .productListModel.productList?.length ??
                      0
                  : widget.remark == 'Special'
                      ? specialProductController
                              .productListModel.productList?.length ??
                          0
                      : newProductController
                              .productListModel.productList?.length ??
                          0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.90,
                mainAxisSpacing: 8,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ProductCardItem(
                    product: widget.remark == 'Popular'
                        ? popularProductController
                            .productListModel.productList![index]
                        : widget.remark == 'Special'
                            ? specialProductController
                                .productListModel.productList![index]
                            : newProductController
                                .productListModel.productList![index],
                    isWishListScreen: false,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
