import 'package:bdhs_restaurant_app/src/features/home/provider/home_provider.dart';
import 'package:bdhs_restaurant_app/src/features/order/provider/order_provider.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/text_size.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../tile/order_tile.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  @override
  void initState() {
    final OrderProvider orderProvider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await orderProvider.initializeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final OrderProvider orderProvider = Provider.of(context);
    final HomeProvider homeProvider = Provider.of(context);

    return SafeArea(
      child: Scaffold(
          body: orderProvider.initialLoading
              ? ShimmerWidget(child: _bodyUI(context, orderProvider, homeProvider, size))
              : _bodyUI(context, orderProvider, homeProvider, size)),
    );
  }

  Widget _bodyUI(BuildContext context, OrderProvider orderProvider, HomeProvider homeProvider, Size size) =>
      Column(
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
                                  Text(
                                    '${homeProvider.loginResponseModel?.user?.name??'N/A'}',
                                    style: const TextStyle(
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
                                    child: Text(
                                      homeProvider.loginResponseModel?.user?.roleType??'N/A',
                                      style: const TextStyle(
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
                      const Positioned(
                          left: 16,
                          right: 16,
                          bottom: 4,
                          child: Text(
                            'Order List',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: TextSize.largeTitleText,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )),
            ],
          ),

          ///Order List
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              children: [
                ///Pending Order
                if(orderProvider.pendingOrderList.isNotEmpty)
                const Text('Pending Order',
                    style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: TextSize.bodyText,
                        fontWeight: FontWeight.bold)),
                if(orderProvider.pendingOrderList.isNotEmpty)
                const Divider(color: Colors.black, thickness: 0.5, height: 4),
                ListView.separated(
                  padding: const EdgeInsets.only(top: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderProvider.pendingOrderList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) =>
                      OrderTile(model: orderProvider.pendingOrderList[index],trailingColor: Colors.red),
                ),
                const SizedBox(height: 20),

                ///Processing Order
                if(orderProvider.processingOrderList.isNotEmpty)
                const Text('Processing Order',
                    style: TextStyle(
                        color: AppColor.warningColor,
                        fontSize: TextSize.bodyText,
                        fontWeight: FontWeight.bold)),
                if(orderProvider.processingOrderList.isNotEmpty)
                const Divider(color: Colors.black, thickness: 0.5, height: 4),
                ListView.separated(
                  padding: const EdgeInsets.only(top: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderProvider.processingOrderList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) =>
                      OrderTile(model: orderProvider.processingOrderList[index],trailingColor: AppColor.warningColor),
                ),
                const SizedBox(height: 20),

                ///Complete Order
                if(orderProvider.completeOrderList.isNotEmpty)
                const Text('Complete Order',
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: TextSize.bodyText,
                        fontWeight: FontWeight.bold)),
                if(orderProvider.completeOrderList.isNotEmpty)
                const Divider(color: Colors.black, thickness: 0.5, height: 4),
                ListView.separated(
                  padding: const EdgeInsets.only(top: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderProvider.completeOrderList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) =>
                      OrderTile(model: orderProvider.processingOrderList[index],trailingColor: AppColor.primaryColor),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      );
}
