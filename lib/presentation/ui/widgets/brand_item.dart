import 'package:crafty_bay/data/models/banner/brand_model.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  const BrandItem({
    super.key,
    required this.brand,
  });

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   () => ProductListScreen(
        //     category: brand.categoryName ?? '',
        //     categoryId: category.id,
        //   ),
        // );
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                brand.brandImg ?? '',
                width: 40,
                height: 40,
              ),
            ),
          ),
          Text(
            brand.brandName ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
