import 'package:flutter/Material.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/text_size.dart';
import '../../../../core/widgets/solid_button.dart';
import '../tile/order_details_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          ///Header
          Stack(
            children: [
              Image.asset(
                'assets/images/home/food.jpg',
                width: size.width,
                height: size.height * .24,
                fit: BoxFit.cover,
              ),
              Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * .24,
                  color: Colors.black.withOpacity(0.4),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                          left: 16,
                          right: 16,
                          top: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColor.appBodyBg,
                                radius: 24,
                                child: Icon(Icons.person,
                                    size: 36, color: AppColor.primaryColor),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Mr. Steven',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: TextSize.bodyText,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: const BoxDecoration(
                                        color: AppColor.secondaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: const Text(
                                      'Restaurant',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: TextSize.smallText),
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: Text(
                                  'Lettuce\nEat',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      height: 1,
                                      color: Colors.white,
                                      fontSize: TextSize.titleText,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),
                      Positioned(
                          left: 16,
                          right: 16,
                          bottom: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '#S123 - Order Details',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: TextSize.largeTitleText,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(Icons.picture_as_pdf,
                                      color: Colors.white))
                            ],
                          )),
                    ],
                  )),
            ],
          ),

          Expanded(
              child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  children: [
                ///Customer Details
                const Text('Customer Details',
                    style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: TextSize.bodyText,
                        fontWeight: FontWeight.bold)),
                const Divider(color: Colors.black, thickness: 0.5, height: 4),

                Row(
                  children: [
                    ///Name
                    Expanded(
                        flex: 2,
                        child: Row(children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FittedBox(
                                child: Text('Customer Name',
                                    style: TextStyle(
                                        fontSize: TextSize.buttonText)),
                              ),
                              Text('Order Time',
                                  style: TextStyle(
                                      fontSize: TextSize.smallText,
                                      color: AppColor.secondaryTextColor)),
                              Text('Payment Type',
                                  style: TextStyle(
                                      fontSize: TextSize.smallText,
                                      color: AppColor.secondaryTextColor)),
                              Text('Amount',
                                  style: TextStyle(
                                      fontSize: TextSize.smallText,
                                      color: AppColor.secondaryTextColor)),
                            ],
                          ))
                        ])),

                    ///Value
                    Expanded(
                        flex: 2,
                        child: Row(children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FittedBox(
                                child: Text(': Mr. X Hacking',
                                    style: TextStyle(
                                        fontSize: TextSize.buttonText)),
                              ),
                              Text(': 09:35',
                                  style: TextStyle(
                                      fontSize: TextSize.smallText,
                                      color: AppColor.secondaryTextColor)),
                              Text(': COD',
                                  style: TextStyle(
                                      fontSize: TextSize.smallText,
                                      color: AppColor.secondaryTextColor)),
                              Text(': \$45',
                                  style: TextStyle(
                                      fontSize: TextSize.smallText,
                                      color: AppColor.secondaryTextColor)),
                            ],
                          ))
                        ])),

                    ///Trailing
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Pending Order\n',
                                  style: TextStyle(
                                      fontSize: TextSize.extraSmallText)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: Text('12-03-24 : 09-12-24',
                                          style: TextStyle(
                                              fontSize: TextSize.extraSmallText,
                                              color: AppColor
                                                  .secondaryTextColor))),
                                  const Icon(Icons.access_time_rounded,
                                      size: 14)
                                ],
                              )
                            ]))
                  ],
                ),
                const SizedBox(height: 32),

                ///Order Item
                const OrderDetailsTile(
                    isHeader: true,
                    item: '# Item Name',
                    quantity: 'Qt.',
                    price: 'Price',
                    total: 'Total'),
                const Divider(color: Colors.black, thickness: 0.5, height: 8),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      separatorBuilder: (context, index)=>const SizedBox(height: 8),
                      itemBuilder: (context, index)=>OrderDetailsTile(
                          item: '0${index+1} Hamburger',
                          quantity: '02',
                          price: '\$ 4.00',
                          total: '\$ 4.00'),
                    ),
                    const SizedBox(height: 32),

                    ///Total
                    const Divider(color: Colors.black, thickness: 0.5, height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: TextSize.bodyText,
                                color: AppColor.secondaryTextColor,
                                fontWeight: FontWeight.bold
                            )),
                        Text('\$ 16.0',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: TextSize.bodyText,
                                color: AppColor.secondaryTextColor,
                                fontWeight: FontWeight.bold
                            ))
                      ],
                    ),
                    const SizedBox(height: 32),

                    ///Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SolidButton(
                            onTap: () async {},
                            child: const Text(
                              'Order Ready',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.buttonText,
                                  fontWeight: FontWeight.bold),
                            )),

                        SolidButton(
                            onTap: () async {},
                            backgroundColor: AppColor.secondaryColor,
                            child: const Text(
                              'Cancel Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.buttonText,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
              ]))
        ],
      ),
    ));
  }
}
