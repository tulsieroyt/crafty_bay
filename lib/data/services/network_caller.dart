import 'dart:convert';
import 'dart:developer';

import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log(url);
    log(token.toString());
    final Response response = await get(
      Uri.parse(url),
      headers: {
        'token': (token ?? AuthController.token).toString(),
        'Content-type': 'application/json'
      },
    );
    log(response.headers.toString());
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      //AuthController.goToLogin();
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) async {
    log(url);
    log(body.toString());
    log('Response ${jsonEncode(body)}');

    final Response response = await post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'token': token ?? AuthController.token.toString(),
        'Content-type': 'application/json'
      },
    );
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      //AuthController.goToLogin();
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  ///This is only for invoice list controller because it does not return any kind of
  ///success message, it will give an error, that's why This special post method is created
  Future<ResponseData> specialGetRequest(String url, {String? token}) async {
    log(url);
    log(token.toString());
    final Response response = await get(
      Uri.parse(url),
      headers: {
        'token': (token ?? AuthController.token).toString(),
        'Content-type': 'application/json'
      },
    );
    log(response.headers.toString());
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return ResponseData(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: decodedResponse,
      );
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      //AuthController.goToLogin();
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}
