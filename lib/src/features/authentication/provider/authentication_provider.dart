import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/Material.dart';
import '../../../../core/constants/local_storage_key.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/app_navigator_key.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../core/utils/validator.dart';
import '../../../../shared/api/api_service.dart';
import '../model/login_response_model.dart';
import '../repository/auth_repository.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool loading = false;
  bool googleLoading = false;
  bool facebookLoading = false;
  final GlobalKey<FormState> signupFormKey = GlobalKey();
  final GlobalKey<FormState> signInFormKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool rememberMe = true;
  bool privacyPolicyUrl = true;
  bool sentPasswordResetLink = false;

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void clearAllData() {
    loading = false;
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  void clearPassword() {
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> signupButtonOnTap() async {
    if (!signupFormKey.currentState!.validate()) {
      return;
    }
    if (!validateEmail(emailController.text)) {
      showToast('Invalid email address');
      return;
    }
    if (!validatePassword(passwordController.text)) {
      showToast('Password must be 6 character');
      return;
    }
    if (!validatePassword(confirmPasswordController.text)) {
      showToast('Password must be 6 character');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showToast('Password does\'nt match');
      return;
    }
    loading = true;
    notifyListeners();

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final String? fcmToken = await firebaseMessaging.getToken();

    if(fcmToken==null){
      loading = false;
      notifyListeners();
      showToast('Error getting device token');
      return;
    }
    Map<String, dynamic> requestBody = {
      "name": nameController.text,
      "email": emailController.text,
      "mobile_number": phoneController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "address": addressController.text,
      "device_id": fcmToken};

    await _authRepository.signup(requestBody: requestBody).then((response) {
      loading = false;
      notifyListeners();
      if (response != null) {
        clearAllData();
        Navigator.pop(AppNavigatorKey.key.currentState!.context);
      }
    });
  }

  Future<void> signInButtonOnTap() async {
    if (!signInFormKey.currentState!.validate()) {
      return;
    }
    if (!validateEmail(emailController.text)) {
      showToast('Invalid email address');
      return;
    }
    loading = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "username": emailController.text,
      "password": passwordController.text};

    await _authRepository.signIn(requestBody: requestBody).then(
            (LoginResponseModel? response) async {
          if (response != null) {
            await setData(LocalStorageKey.loginResponseKey,
                loginResponseModelToJson(response))
                .then((value) async {
              final BuildContext context = AppNavigatorKey.key.currentState!.context;
              ApiService.instance.addToken(response.token!);
              clearAllData();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRouter.home, (route) => false);
            }, onError: (error) {
              showToast(error.toString());
            });
          }
        }, onError: (error) {
      showToast(error.toString());
    });
    loading = false;
    notifyListeners();
  }
}
