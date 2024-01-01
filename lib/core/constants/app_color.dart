import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xff416A18);
  static const int primarySwatch = 0xff416A18;
  static const Color secondaryColor = Color(0xffF60505);

  static const Color errorColor = Colors.red;
  static const Color enableColor = Colors.green;
  static const Color disableColor = Colors.grey;
  static const Color warningColor = Color.fromARGB(255, 217, 155, 9);

  static const Color appBodyBg = Color(0xffFFFFFF);
  static const Color appbarBgColor = primaryColor;
  static const Color cardColor = Color(0xffFFFFFF);
  static const Color bottomSheetColor = Color(0xffFFFFFF);
  static const Color navBarBgColor = secondaryColor;

  static const Color textFieldHintColor = Color(0xff9CA3AF);
  static const Color textFieldFillColor = Color(0xffEEEEEE);
  static const Color textFieldIconColor = Color(0xff9CA3AF);
  static const Color textFieldOutlineColor = Colors.grey;

  static final Color textColor = Colors.grey.shade900;
  static final Color secondaryTextColor = Colors.grey.shade700;

  static const Map<int, Color> primaryColorMap = {
    50: Color.fromRGBO(65, 106, 24, .1),
    100: Color.fromRGBO(65, 106, 24, .2),
    200: Color.fromRGBO(65, 106, 24, .3),
    300: Color.fromRGBO(65, 106, 24, .4),
    400: Color.fromRGBO(65, 106, 24, .5),
    500: Color.fromRGBO(65, 106, 24, .6),
    600: Color.fromRGBO(65, 106, 24, .7),
    700: Color.fromRGBO(65, 106, 24, .8),
    800: Color.fromRGBO(65, 106, 24, .9),
    900: Color.fromRGBO(65, 106, 24, 1)
  };
}
