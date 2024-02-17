import 'package:crafty_bay/presentation/state_holders/auth/read_customer_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review/create_review_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/shack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _ratingTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ReadCustomerProfileController readCustomerProfileController =
      Get.find<ReadCustomerProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _ratingTEController,
                  decoration: const InputDecoration(
                    hintText: 'Give rating',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      if (int.parse(value!) > 5) {
                        return 'Enter 0 to 5 only';
                      }
                      return 'Enter your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _reviewTEController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Write Review',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'You Must have to write something!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CreateReviewController>(
                    builder: (createReviewController) {
                  return Visibility(
                    visible: createReviewController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final result =
                                await createReviewController.createReview(
                                    widget.productId,
                                    _reviewTEController.text.trim(),
                                    int.parse(_ratingTEController.text));
                            if (result) {
                              Get.back();
                              if (mounted) {
                                SnackMessage.showMessage(
                                    title: 'Review created successfully',
                                    message: 'Thanks for your review');
                              }
                            } else {
                              SnackMessage.showMessage(
                                  title: 'Review creation failed',
                                  message: createReviewController.errorMessage);
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ratingTEController.dispose();
    _reviewTEController.dispose();
    super.dispose();
  }
}
