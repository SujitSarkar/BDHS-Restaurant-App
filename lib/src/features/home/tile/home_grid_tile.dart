import 'package:flutter/Material.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/text_size.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile(
      {Key? key,
      required this.borderColor,
      required this.leadingAsset,
      required this.title,
      required this.subtitle,
      required this.titleColor,
      this.onTap})
      : super(key: key);
  final Color borderColor;
  final Color titleColor;
  final String leadingAsset;
  final String title;
  final String subtitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColor.cardColor,
            border: Border.all(color: borderColor, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(4, 6))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              leadingAsset,
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: titleColor,
                        fontSize: TextSize.largeTitleText,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        color: AppColor.secondaryTextColor,
                        fontSize: TextSize.smallText),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
