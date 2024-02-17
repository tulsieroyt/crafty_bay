import 'package:crafty_bay/data/models/invoice_list_item.dart';
import 'package:crafty_bay/presentation/state_holders/invoice_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<InvoiceListController>().getInvoiceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Invoice'),
      ),
      body: GetBuilder<InvoiceListController>(builder: (invoiceListController) {
        return ListView.separated(
          itemCount: invoiceListController.invoiceListItem.length,
          itemBuilder: (context, index) {
            InvoiceListItem invoiceItem =
                invoiceListController.invoiceListItem[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  'Invoice No: ${index + 1}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                Text('Total: ${invoiceItem.total}'),
                Text('Vat: ${invoiceItem.vat}'),
                Text('Payable: ${invoiceItem.payable}'),
                Text('Transaction ID: ${invoiceItem.tranId}'),
                Text('Delivery Status: ${invoiceItem.deliveryStatus}'),
                Text('Payment Status: ${invoiceItem.paymentStatus}'),
                Text('Customer Address: ${invoiceItem.cusDetails}'),
                Text('Shipping Address: ${invoiceItem.shipDetails}'),
              ],
            );
          },
          separatorBuilder: (_, __) {
            return const Divider(
              thickness: 1,
              height: 1,
            );
          },
        );
      }),
    );
  }
}
