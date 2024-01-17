import 'package:bdhs_restaurant_app/src/features/profile/repository/profile_repository.dart';
import 'package:flutter/Material.dart';
import '../../../../core/constants/local_storage_key.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../shared/api/api_service.dart';
import '../../authentication/model/login_response_model.dart';

class ProfileProvider extends ChangeNotifier{
  static final ProfileRepository _profileRepository = ProfileRepository();
  bool initialLoading = false;
  bool functionLoading = false;
  bool isDataUpdatable = false;

  ///User Data
  LoginResponseModel? loginResponseModel;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> initializeData() async {
    initialLoading=true;
    notifyListeners();
    await getLocalData();
    initialLoading=false;
    notifyListeners();
  }

  Future<void> getLocalData() async {
    final loginResponseFromLocal =
    await getData(LocalStorageKey.loginResponseKey);
    debugPrint('LoginModel from local:::: $loginResponseFromLocal');
    if (loginResponseFromLocal != null) {
      loginResponseModel = loginResponseModelFromJson(loginResponseFromLocal);
      debugPrint('Token:- ${ApiService.instance.token}');
      nameController.text = loginResponseModel!.user!.name??'';
      emailController.text = loginResponseModel!.user!.email??'';
      phoneController.text = loginResponseModel!.user!.mobileNumber??'';
    }
  }

  void checkIsDataUpdatable(){
    if( nameController.text != loginResponseModel!.user!.name ||
        emailController.text != loginResponseModel!.user!.email ||
        phoneController.text != loginResponseModel!.user!.mobileNumber){
      isDataUpdatable = true;
    }else{
      isDataUpdatable = false;
    }
    notifyListeners();
  }
}