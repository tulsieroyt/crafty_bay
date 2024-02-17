import 'dart:developer';

import 'package:crafty_bay/data/models/invoice_list_item.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class InvoiceListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  late List<dynamic> _invoiceListItem = [];

  List<dynamic> get invoiceListItem => _invoiceListItem;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> getInvoiceList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().specialGetRequest(Urls.invoiceList);
    if (response.isSuccess) {
      _invoiceListItem = response.responseData
          .map((json) => InvoiceListItem.fromJson(json))
          .toList();
      log(_invoiceListItem.toString());
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
