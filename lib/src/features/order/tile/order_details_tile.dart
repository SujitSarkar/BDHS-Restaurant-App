import 'package:flutter/Material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/text_size.dart';

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile(
      {super.key,
      required this.item,
      required this.quantity,
      required this.price,
      required this.total,
      this.isHeader = false});

  final String item;
  final String quantity;
  final String price;
  final String total;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(item,
              style: TextStyle(
                fontSize: TextSize.bodyText,
                color: isHeader?AppColor.secondaryColor:AppColor.secondaryTextColor,
                fontWeight: isHeader?FontWeight.bold: FontWeight.w500
              )),
        ),

        Expanded(
          flex: 1,
          child: Text(quantity,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: TextSize.bodyText,
                  color: isHeader?AppColor.secondaryColor:AppColor.secondaryTextColor,
                  fontWeight: isHeader?FontWeight.bold: FontWeight.w500
              )),
        ),

        Expanded(
          flex: 1,
          child: Text(price,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: TextSize.bodyText,
                  color: isHeader?AppColor.secondaryColor:AppColor.secondaryTextColor,
                  fontWeight: isHeader?FontWeight.bold: FontWeight.w500
              )),
        ),

        Expanded(
          flex: 1,
          child: Text(total,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: TextSize.bodyText,
                  color: isHeader?AppColor.secondaryColor:AppColor.secondaryTextColor,
                  fontWeight: isHeader?FontWeight.bold: FontWeight.w500
              )),
        ),
      ],
    );
  }
}
