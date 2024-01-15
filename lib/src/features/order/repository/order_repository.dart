import 'dart:convert';
import 'package:bdhs_restaurant_app/src/features/order/model/order_list_data_model.dart';
import 'package:flutter/Material.dart';
import '../../../../shared/api/api_endpoint.dart';
import '../../../../shared/api/api_service.dart';

class OrderRepository {
  Future<List<OrderListDataModel>> getOrderList({required orderEndpoint}) async {
    List<OrderListDataModel> result = [];
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.get(
          '${ApiEndpoint.baseUrl}$orderEndpoint',
          addToken: true);
    }, onSuccess: (response) async {
      var jsonData = jsonDecode(response.body);
      if(jsonData['data']!=null && jsonData['data'].isNotEmpty){
        result = orderListDataModelFromJson(jsonEncode(jsonData['data']));
      }
    }, onError: (error) {
      debugPrint(error.message ?? 'Something went wrong');
    });
    return result;
  }

  Future<List<OrderListDataModel>> orderProcessing({required orderEndpoint}) async {
    List<OrderListDataModel> result = [];
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.get(
          '${ApiEndpoint.baseUrl}$orderEndpoint',
          addToken: true);
    }, onSuccess: (response) async {
      debugPrint(response.body);
      var jsonData = jsonDecode(response.body);
      if(jsonData['data']!=null && jsonData['data'].isNotEmpty){
        result = orderListDataModelFromJson(jsonEncode(jsonData['data']));
      }
    }, onError: (error) {
      debugPrint(error.message ?? 'Something went wrong');
    });
    return result;
  }
}
