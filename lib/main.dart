import 'package:bdhs_restaurant_app/shared/push_notification_service/firebase_push_api_service.dart';
import 'package:bdhs_restaurant_app/src/features/authentication/provider/authentication_provider.dart';
import 'package:bdhs_restaurant_app/src/features/home/provider/home_provider.dart';
import 'package:bdhs_restaurant_app/src/features/order/provider/order_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_string.dart';
import 'core/constants/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/router/app_router_settings.dart';
import 'core/utils/app_navigator_key.dart';
import 'firebase_options.dart';

Future<void> handleMessage(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint('::::onBackgroundMessage::::');
    debugPrint('\nNotification Title: ${message.notification?.title}');
    debugPrint('\nNotification Body: ${message.notification?.body}');
    debugPrint('\nNotification Payload: ${message.data}');
    Navigator.pushNamed(AppNavigatorKey.key.currentState!.context, AppRouter.orderList);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebasePushApiService().initNotification();
  FirebaseMessaging.onBackgroundMessage(handleMessage);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthenticationProvider>(
              create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider<HomeProvider>(create: (_)=> HomeProvider()),
          ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigatorKey.key,
          title: AppString.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          initialRoute: AppRouter.initializer,
          onGenerateRoute: (RouteSettings settings) =>
              GeneratedRoute.onGenerateRoute(settings),
        ));
  }
}
