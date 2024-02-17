import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/read_customer_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/invoice_list_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/profile_details_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReadCustomerProfileController>()
        .readCustomerData(AuthController.token.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Details'),
        actions: [
          TextButton(
              onPressed: () {
                Get.to(() => const InvoiceListScreen());
              },
              child: const Text('Your Invoice'))
        ],
      ),
      body: GetBuilder<ReadCustomerProfileController>(
          builder: (readCustomerProfileController) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      customerImageAvatar,
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        readCustomerProfileController.customerProfile.cusName ??
                            '',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        readCustomerProfileController
                                .customerProfile.user?.email ??
                            '',
                        maxLines: 1,
                      ),
                      editProfileButton,
                      const SizedBox(
                        height: 30,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black54.withOpacity(.2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileDetailsOptions(
                              title: 'Address:',
                              description: readCustomerProfileController
                                      .customerProfile.cusAdd ??
                                  '',
                            ),
                            ProfileDetailsOptions(
                                title: 'Mobile',
                                description: readCustomerProfileController
                                        .customerProfile.cusPhone ??
                                    ''),
                            ProfileDetailsOptions(
                              title: 'Fax:',
                              description: readCustomerProfileController
                                      .customerProfile.cusFax ??
                                  '',
                            ),
                            ProfileDetailsOptions(
                              title: 'City:',
                              description: readCustomerProfileController
                                      .customerProfile.cusCity ??
                                  '',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.black54.withOpacity(.2),
                            ),
                            const Text(
                              'Shipping Address',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ProfileDetailsOptions(
                              title: 'Name:',
                              description: readCustomerProfileController
                                      .customerProfile.shipName ??
                                  '',
                            ),
                            ProfileDetailsOptions(
                              title: 'Address:',
                              description: readCustomerProfileController
                                      .customerProfile.shipAdd ??
                                  '',
                            ),
                            ProfileDetailsOptions(
                              title: 'City:',
                              description: readCustomerProfileController
                                      .customerProfile.shipCity ??
                                  '',
                            ),
                            ProfileDetailsOptions(
                              title: 'Country:',
                              description: readCustomerProfileController
                                      .customerProfile.shipCountry ??
                                  '',
                            ),
                            ProfileDetailsOptions(
                              title: 'Phone Number:',
                              description: readCustomerProfileController
                                      .customerProfile.shipPhone ??
                                  '',
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await AuthController.clearAuthData();
                      Get.offAll(() => const MainBottomNavScreen());
                    },
                    child: const Text('Log out')),
              )
            ],
          ),
        );
      }),
    );
  }

  SizedBox get editProfileButton {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => CompleteProfileScreen(
                token: AuthController.token,
              ));
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Container get customerImageAvatar {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const CircleAvatar(),
            ),
          ),
        ),
      ),
    );
  }
}
