import 'dart:developer';

import 'package:crafty_bay/data/models/create_profile_params.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth/read_customer_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, this.token});

  final String? token;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _customerNameTEController =
      TextEditingController();
  final TextEditingController _customerCityTEController =
      TextEditingController();
  final TextEditingController _customerStateTEController =
      TextEditingController();
  final TextEditingController _customerPostCodeTEController =
      TextEditingController();
  final TextEditingController _customerCountryTEController =
      TextEditingController();
  final TextEditingController _customerPhoneNumberTEController =
      TextEditingController();
  final TextEditingController _customerFaxTEController =
      TextEditingController();
  final TextEditingController _customerAddressTEController =
      TextEditingController();
  final TextEditingController _shipNameTEController = TextEditingController();
  final TextEditingController _shipCityTEController = TextEditingController();
  final TextEditingController _shipStateTEController = TextEditingController();
  final TextEditingController _shipPostTEController = TextEditingController();
  final TextEditingController _shipCountryTEController =
      TextEditingController();
  final TextEditingController _shipPhoneTEController = TextEditingController();
  final TextEditingController _shipAddressTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ReadCustomerProfileController readCustomerProfileController =
      Get.find<ReadCustomerProfileController>();

  @override
  void initState() {
    super.initState();
    readCustomerProfileController
        .readCustomerData(widget.token ?? AuthController.token.toString());
    log('AuthController token is:');
    log(AuthController.token.toString());
    if (readCustomerProfileController.isProfileCompleted) {
      _customerNameTEController.text =
          readCustomerProfileController.customerProfile.cusName ?? '';
      _customerAddressTEController.text =
          readCustomerProfileController.customerProfile.cusAdd ?? '';
      _customerCityTEController.text =
          readCustomerProfileController.customerProfile.cusCity ?? '';
      _customerStateTEController.text =
          readCustomerProfileController.customerProfile.cusState ?? '';
      _customerPostCodeTEController.text =
          readCustomerProfileController.customerProfile.cusPostcode ?? '';
      _customerCountryTEController.text =
          readCustomerProfileController.customerProfile.cusCity ?? '';
      _customerPhoneNumberTEController.text =
          readCustomerProfileController.customerProfile.cusPhone ?? '';
      _customerFaxTEController.text =
          readCustomerProfileController.customerProfile.cusFax ?? '';
      _shipNameTEController.text =
          readCustomerProfileController.customerProfile.shipName ?? '';
      _shipAddressTEController.text =
          readCustomerProfileController.customerProfile.shipAdd ?? '';
      _shipCityTEController.text =
          readCustomerProfileController.customerProfile.shipCity ?? '';
      _shipStateTEController.text =
          readCustomerProfileController.customerProfile.shipState ?? '';
      _shipPostTEController.text =
          readCustomerProfileController.customerProfile.shipPostcode ?? '';
      _shipCountryTEController.text =
          readCustomerProfileController.customerProfile.shipCountry ?? '';
      _shipPhoneTEController.text =
          readCustomerProfileController.customerProfile.shipPhone ?? '';
    }
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
                  height: 48,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Complete Profile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 28),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Get started with us with your details',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Customer Details',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerNameTEController,
                  decoration: const InputDecoration(hintText: 'Your Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerCityTEController,
                  decoration: const InputDecoration(hintText: 'City'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerStateTEController,
                  decoration: const InputDecoration(hintText: 'State'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your state';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerPostCodeTEController,
                  decoration: const InputDecoration(hintText: 'Post Code'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your post code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerCountryTEController,
                  decoration: const InputDecoration(hintText: 'Country'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your country';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerPhoneNumberTEController,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerFaxTEController,
                  decoration: const InputDecoration(hintText: 'Fax'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your fax number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _customerAddressTEController,
                  maxLines: 4,
                  decoration: const InputDecoration(hintText: 'Your address'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Shipping Details',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipNameTEController,
                  decoration: const InputDecoration(hintText: 'Ship Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Ship name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCityTEController,
                  decoration: const InputDecoration(hintText: 'Ship City'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Ship City';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipStateTEController,
                  decoration: const InputDecoration(hintText: 'Ship State'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Ship State';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPostTEController,
                  decoration: const InputDecoration(hintText: 'Ship Post Code'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Ship Post Code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCountryTEController,
                  decoration: const InputDecoration(hintText: 'Ship Country'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Ship Country';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPhoneTEController,
                  decoration:
                      const InputDecoration(hintText: 'Ship Phone Number'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Ship Phone Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipAddressTEController,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(hintText: 'Shipping address'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your shipping address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CompleteProfileController>(
                      builder: (completeProfileController) {
                    return Visibility(
                      visible: completeProfileController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final createProfileParams = CreateProfileParams(
                              cusName: _customerNameTEController.text.trim(),
                              cusAdd: _customerAddressTEController.text.trim(),
                              cusCity: _customerCityTEController.text.trim(),
                              cusState: _customerStateTEController.text.trim(),
                              cusPostcode:
                                  _customerPostCodeTEController.text.trim(),
                              cusCountry:
                                  _customerCountryTEController.text.trim(),
                              cusPhone:
                                  _customerPhoneNumberTEController.text.trim(),
                              cusFax: _customerFaxTEController.text.trim(),
                              shipName: _shipNameTEController.text.trim(),
                              shipAdd: _shipAddressTEController.text.trim(),
                              shipCity: _shipCityTEController.text.trim(),
                              shipState: _shipStateTEController.text.trim(),
                              shipPostcode: _shipPostTEController.text.trim(),
                              shipCountry: _shipCountryTEController.text.trim(),
                              shipPhone: _shipPhoneTEController.text.trim(),
                            );
                            log(Get.find<VerifyOTPController>()
                                .token
                                .toString());
                            final bool result = await completeProfileController
                                .createProfileData(
                                    Get.find<VerifyOTPController>().token,
                                    createProfileParams);
                            if (result) {
                              Get.offAll(() => const MainBottomNavScreen());
                            } else {
                              Get.showSnackbar(GetSnackBar(
                                title: 'Complete profile failed',
                                message: completeProfileController.errorMessage,
                                duration: const Duration(seconds: 2),
                                isDismissible: true,
                              ));
                            }
                          }
                        },
                        child: const Text('Complete'),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customerNameTEController.dispose();
    _customerAddressTEController.dispose();
    _customerCityTEController.dispose();
    _customerStateTEController.dispose();
    _customerPostCodeTEController.dispose();
    _customerCountryTEController.dispose();
    _customerPhoneNumberTEController.dispose();
    _customerFaxTEController.dispose();
    _shipNameTEController.dispose();
    _shipAddressTEController.dispose();
    _shipCityTEController.dispose();
    _shipStateTEController.dispose();
    _shipPostTEController.dispose();
    _shipCountryTEController.dispose();
    _shipPhoneTEController.dispose();
    super.dispose();
  }
}
