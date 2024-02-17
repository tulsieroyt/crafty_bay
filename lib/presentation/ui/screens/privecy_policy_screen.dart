import 'package:crafty_bay/presentation/state_holders/privacy_policy/about_privecy_policy_controller.dart';
import 'package:crafty_bay/presentation/state_holders/privacy_policy/refund_privacy_policy_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<AboutPrivacyPolicyController>().getAboutPrivacyPolicyByType();
    Get.find<RefundPrivacyPolicyController>().getRefundPrivacyPolicyByType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      'About Us',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  GetBuilder<AboutPrivacyPolicyController>(
                      builder: (aboutPrivacyPolicyController) {
                    return Visibility(
                      visible: aboutPrivacyPolicyController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: Text(
                        aboutPrivacyPolicyController.privacyPolicyModel.des
                            .toString(),
                      ),
                    );
                  })
                ],
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      'Refund Policy',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  GetBuilder<RefundPrivacyPolicyController>(
                      builder: (refundPrivacyPolicyController) {
                    return Visibility(
                      visible:
                          refundPrivacyPolicyController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: Text(
                        refundPrivacyPolicyController.privacyPolicyModel.des
                            .toString(),
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
