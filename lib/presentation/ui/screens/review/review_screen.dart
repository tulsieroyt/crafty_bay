import 'dart:developer';

import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review/review_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/review/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewController>().getReviewList(categoryId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: GetBuilder<ReviewController>(builder: (reviewController) {
        log(widget.productId.toString());
        return Column(
          children: [
            Expanded(
              child: Visibility(
                visible: reviewController.inProgress == false,
                replacement: const CenterCircularProgressIndicator(),
                child: reviewController.listOfReview.reviewData?.isEmpty ?? true
                    ? const Center(
                        child: Text('No Review'),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            reviewController.listOfReview.reviewData?.length ??
                                0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(.5),
                                          child: const Icon(
                                            Icons.person,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          reviewController
                                              .listOfReview
                                              .reviewData![index]
                                              .reviewProfile!
                                              .cusName
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    reviewController.listOfReview
                                        .reviewData![index].description
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                      ),
              ),
            ),
            totalReviewCard(
                reviewController.listOfReview.reviewData?.length ?? 0)
          ],
        );
      }),
    );
  }

  Container totalReviewCard(int totalReview) {
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
                'Total Review',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              Text(
                '$totalReview',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                if (AuthController.token != null) {
                  Get.to(
                    () => CreateReviewScreen(
                      productId: widget.productId,
                    ),
                  );
                } else {
                  Get.offAll(() => const VerifyEmailScreen());
                }
              },
              child: const Text('Create Review'),
            ),
          ),
        ],
      ),
    );
  }
}
