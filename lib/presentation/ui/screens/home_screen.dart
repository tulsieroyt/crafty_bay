import 'dart:developer';

import 'package:crafty_bay/data/models/product/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/brand_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/customer_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/brand_list_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/popular_special_new_product_lis_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/privecy_policy_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/brand_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/circle_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/banner_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/section_title.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              searchTextField,
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 210,
                child: GetBuilder<HomeBannerController>(
                    builder: (homeBannerController) {
                  return Visibility(
                    visible: homeBannerController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: BannerCarousel(
                      bannerList:
                          homeBannerController.bannerListModel.bannerList ?? [],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: 'All Categories',
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              SectionTitle(
                title: 'All Brands',
                onTapSeeAll: () {
                  Get.to(const BrandListScreen());
                },
              ),
              brandList,
              SectionTitle(
                title: 'Popular',
                onTapSeeAll: () {
                  Get.to(() => const PopularSpecialNewProductListScreen(
                      remark: 'Popular'));
                },
              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                return Visibility(
                  visible: popularProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                    popularProductController.productListModel.productList ?? [],
                  ),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: 'Special',
                onTapSeeAll: () {
                  Get.to(() => const PopularSpecialNewProductListScreen(
                      remark: 'Special'));
                },
              ),
              GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                return Visibility(
                  visible: specialProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                    specialProductController.productListModel.productList ?? [],
                  ),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: 'New',
                onTapSeeAll: () {
                  Get.to(() =>
                      const PopularSpecialNewProductListScreen(remark: 'New'));
                },
              ),
              GetBuilder<NewProductController>(builder: (newProductController) {
                return Visibility(
                  visible: newProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      newProductController.productListModel.productList ?? []),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
      height: 130,
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        return Visibility(
          visible: categoryController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount:
                categoryController.categoryListModel.categoryList?.length ?? 0,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryItem(
                category:
                    categoryController.categoryListModel.categoryList![index],
                isBrand: false,
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox get brandList {
    return SizedBox(
      height: 130,
      child: GetBuilder<BrandController>(builder: (brandController) {
        return Visibility(
          visible: brandController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount: brandController.brandListModel.brandList?.length ?? 0,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BrandItem(
                  brand: brandController.brandListModel.brandList![index]);
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox productList(List<ProductModel> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: productList.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCardItem(
            product: productList[index],
            isWishListScreen: false,
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  TextFormField get searchTextField {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () {
            if (AuthController.token != null) {
              Get.to(() => const CustomerProfileScreen());
            } else {
              Get.to(() => const VerifyEmailScreen());
            }
          },
          iconData: Icons.person,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {
            log(AuthController.token.toString());
          },
          iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {
            Get.to(()=> const PrivacyPolicyScreen());
          },
          iconData: Icons.info_outline,
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
