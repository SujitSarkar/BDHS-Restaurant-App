import 'package:flutter/Material.dart';
import '../../../../core/constants/local_storage_key.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../shared/api/api_service.dart';
import '../../authentication/model/login_response_model.dart';
import '../model/dashboard_data_model.dart';
import '../repository/home_repository.dart';

class HomeProvider extends ChangeNotifier{
  final HomeRepository _homeRepository = HomeRepository();
  bool initialLoading = false;
  DashboardDataModel? dashboardDataModel;

  ///User Data
  LoginResponseModel? loginResponseModel;

  Future<void> initializeData() async {
    initialLoading=true;
    notifyListeners();
    await getLocalData();
    await getDashboardData();
    initialLoading=false;
    notifyListeners();
  }

  Future<void> getLocalData() async {
    final loginResponseFromLocal =
    await getData(LocalStorageKey.loginResponseKey);
    debugPrint('LoginModel from local: $loginResponseFromLocal');
    if (loginResponseFromLocal != null) {
      loginResponseModel = loginResponseModelFromJson(loginResponseFromLocal);
      ApiService.instance.addToken(loginResponseModel!.token!);
      debugPrint('Token:- ${ApiService.instance.token}');
    }
  }

  Future<void> getDashboardData() async {
    await _homeRepository.dashboardData().then((result) {
      if (result != null) {
        dashboardDataModel = result;
      }
    });
  }
}