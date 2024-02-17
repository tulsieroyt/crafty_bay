import 'dart:developer';

import 'package:crafty_bay/presentation/state_holders/auth/resend_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/send_email_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/shack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final ResendOtpController resendOtpController =
      Get.find<ResendOtpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    resendOtpController.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'A 4 digit OTP code has been sent',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  controller: _otpTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      inactiveColor: AppColors.primaryColor,
                      selectedFillColor: Colors.transparent,
                      selectedColor: Colors.purple),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    log("Completed");
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<VerifyOTPController>(
                      builder: (verifyOtpController) {
                    return Visibility(
                      visible: verifyOtpController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool response = await verifyOtpController
                                .verifyOTP(widget.email, _otpTEController.text);
                            if (response) {
                              if (verifyOtpController
                                  .shouldNavigateCompleteProfile) {
                                Get.to(() => CompleteProfileScreen(
                                      token: verifyOtpController.token,
                                    ));
                              } else {
                                Get.offAll(() => const MainBottomNavScreen());
                              }
                            } else {
                              Get.showSnackbar(GetSnackBar(
                                title: 'OTP verification failed',
                                message: verifyOtpController.errorMessage,
                                duration: const Duration(seconds: 2),
                                isDismissible: true,
                              ));
                            }
                          }
                        },
                        child: const Text('Next'),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                Obx(
                  () => RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        const TextSpan(text: 'Resend '),
                        TextSpan(
                          text: resendOtpController.timeRemaining.toString(),
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => resendOtpController.timeRemaining.value == 0
                      ? TextButton(
                          onPressed: () async {
                            final result =
                                await Get.find<SendEmailOtpController>()
                                    .sendOtpToEmail(widget.email);
                            if (result) {
                              resendOtpController.resendOTP();
                              SnackMessage.showMessage(
                                title: 'Resend Otp Successful',
                                message:
                                    'We have send an OTP to your email. check your email',
                              );
                            } else {
                              SnackMessage.showMessage(
                                title: 'Resend Otp Failed',
                                message: Get.find<SendEmailOtpController>()
                                    .errorMessage,
                              );
                            }
                          },
                          child: const Text('Resend Code',
                              style: TextStyle(color: AppColors.primaryColor)),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Resend Code',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
