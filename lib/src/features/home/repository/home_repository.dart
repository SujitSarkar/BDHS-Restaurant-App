import 'package:flutter/Material.dart';
import '../../../../shared/api/api_endpoint.dart';
import '../../../../shared/api/api_service.dart';
import '../model/dashboard_data_model.dart';

class HomeRepository{

  Future<DashboardDataModel?> dashboardData() async {
    DashboardDataModel? result;
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.get(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.dashboard}',addToken: true);
    }, onSuccess: (response) async {
      debugPrint(response.body);
      result = dashboardDataModelFromJson(response.body);
    }, onError: (error) {
      debugPrint(error.message ?? 'Something went wrong');
    });
    return result;
  }
}