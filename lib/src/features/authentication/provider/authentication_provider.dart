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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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
  }

  void clearPassword() {
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void rememberMeOnChange(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  void privacyPolicyUrlOnChange(bool value) {
    privacyPolicyUrl = value;
    notifyListeners();
  }

  Future<void> signupButtonOnTap() async {
    Navigator.pushNamedAndRemoveUntil(
        AppNavigatorKey.key.currentState!.context, AppRouter.home, (route) => false);
    return;
    if (!signupFormKey.currentState!.validate()) {
      return;
    }
    if (!validateEmail(emailController.text)) {
      showToast('Invalid email address');
      return;
    }
    if (!validatePassword(passwordController.text)) {
      showToast('Password must be at least 6 characters');
      return;
    }
    if (!validatePassword(confirmPasswordController.text)) {
      showToast('Password must be at least 6 characters');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showToast('Password does\'nt match');
      return;
    }
    loading = true;
    notifyListeners();
    Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "name": nameController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "device_name": "Dev1@CF"
    };

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
    Navigator.pushNamedAndRemoveUntil(
        AppNavigatorKey.key.currentState!.context, AppRouter.home, (route) => false);
    return;
    if (!signInFormKey.currentState!.validate()) {
      return;
    }
    if (!validateEmail(emailController.text)) {
      showToast('Invalid email address');
      return;
    }
    if (!validatePassword(passwordController.text)) {
      showToast('Password must be at least 6 characters');
      return;
    }
    loading = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_name": "Dev1@CF",
      "remember": false
    };

    await _authRepository.signIn(requestBody: requestBody).then(
        (LoginResponseModel? response) async {
      if (response != null) {
        await setData(LocalStorageKey.loginResponseKey,
                loginResponseModelToJson(response))
            .then((value) async {
          final BuildContext context =
              AppNavigatorKey.key.currentState!.context;

          ApiService.instance.addAccessToken(response.accessToken);
          clearAllData();
          // Navigator.pushNamedAndRemoveUntil(
          //     context, AppRouter.tabBar, (route) => false);
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
