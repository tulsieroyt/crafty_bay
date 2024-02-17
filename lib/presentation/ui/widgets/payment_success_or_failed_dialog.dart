import 'package:crafty_bay/presentation/ui/screens/cart_list_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessorFailedDialog extends StatelessWidget {
  const PaymentSuccessorFailedDialog({
    super.key,
    required this.isSuccess,
  });

  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Center(
          child: CircleAvatar(
            backgroundColor: isSuccess ? Colors.green : Colors.red,
            child: Icon(
              isSuccess ? Icons.done : Icons.cancel_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              isSuccess ? 'Payment Success' : 'Payment Failed',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(isSuccess ? 'Thanks for purchasing' : 'Something went wrong'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                isSuccess
                    ? Get.offAll(() => const MainBottomNavScreen())
                    : Get.to(const CartListScreen());
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(isSuccess ? 'Continue Shopping' : 'Try Again'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
