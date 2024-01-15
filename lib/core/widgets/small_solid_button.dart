import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class SmallSolidButton extends StatelessWidget {
  const SmallSolidButton(
      {Key? key,
        required this.onTap,
        required this.child,
        this.width,
        this.backgroundColor,
        this.borderRadius,
        this.splashColor})
      : super(key: key);
  final Function() onTap;
  final Widget child;
  final double? width;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final MaterialStateProperty<Color?>? splashColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: backgroundColor ?? AppColor.primaryColor,
            elevation: 0.0,
            fixedSize: Size(width ?? 100, 20),
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ??
                    const BorderRadius.all(Radius.circular(40))))
            .copyWith(
            overlayColor: splashColor??
                MaterialStateProperty.all(Colors.white.withOpacity(0.5))),
        onPressed: onTap,
        child: child);
  }
}
