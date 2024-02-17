import 'package:crafty_bay/presentation/state_holders/brand_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({super.key});

  @override
  State<BrandListScreen> createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Brands',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 3,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<BrandController>().getBrandList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GetBuilder<BrandController>(builder: (brandController) {
            return Visibility(
              visible: brandController.inProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: GridView.builder(
                itemCount:
                    brandController.brandListModel.brandList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.95,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: CategoryItem(
                      brandItem:
                          brandController.brandListModel.brandList![index],
                      isBrand: true,
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
