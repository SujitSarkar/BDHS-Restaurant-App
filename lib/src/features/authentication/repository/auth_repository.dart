import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/Material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/app_navigator_key.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../shared/api/api_endpoint.dart';
import '../../../../shared/api/api_service.dart';
import '../model/login_response_model.dart';

class AuthRepository {
  Future<LoginResponseModel?> signIn(
      {required Map<String, dynamic> requestBody}) async {
    LoginResponseModel? result;
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.post(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.signIn}',
          body: requestBody);
    }, onSuccess: (response) async {
      debugPrint(response.body);
      result = loginResponseModelFromJson(response.body);
    }, onError: (error) {
      debugPrint(error.message ?? 'Something went wrong');
    });
    return result;
  }

  Future<String?> signup({required Map<String, dynamic> requestBody}) async {
    String? result;
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.post(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.signup}',
          body: requestBody);
    }, onSuccess: (response) async {
      result = response.body;
      debugPrint(result);
    }, onError: (error) {
      debugPrint(error.message ?? 'Something went wrong');
    });
    return result;
  }

  Future<void> logout() async {
    await clearLocalData().then((value) {
      ApiService.instance.clearToken();
      Navigator.pushNamedAndRemoveUntil(
          AppNavigatorKey.key.currentState!.context,
          AppRouter.signIn,
              (route) => false);
    });
  }

  Future<String?> generateUserToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint('Device FCM Token is: $fcmToken');
      return fcmToken!;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
