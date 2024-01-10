import 'package:flutter/material.dart';
import '../../src/features/authentication/view/signin_screen.dart';
import '../../src/features/authentication/view/signup_screen.dart';
import '../../src/features/home/screen/home_screen.dart';
import '../../src/features/order/screen/order_details_screen.dart';
import '../../src/features/order/screen/order_list_screen.dart';
import '../../src/features/splash/splash_screen.dart';
import '../widgets/no_internet_screen.dart';
import 'app_router.dart';

class GeneratedRoute {
  static PageRouteBuilder onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.initializer:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const SplashScreen());

      case AppRouter.signIn:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const SignInScreen());

      case AppRouter.signup:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const SignupScreen());

      case AppRouter.home:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const HomeScreen());

      case AppRouter.orderList:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const OrderListScreen());

      case AppRouter.orderDetails:
        final OrderDetailsScreen arguments = settings.arguments as OrderDetailsScreen;
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            OrderDetailsScreen(
              orderModel: arguments.orderModel,
              orderType: arguments.orderType,
            ));

      case AppRouter.noInternet:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const NoInternetScreen());

      default:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const SplashScreen());
    }
  }
  static const transitionDuration = Duration(milliseconds: 500);

  static Widget fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget slideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
