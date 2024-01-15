import 'package:bdhs_restaurant_app/shared/api/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import '../model/order_list_data_model.dart';
import '../repository/order_repository.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();
  bool initialLoading = false;

  List<OrderListDataModel> pendingOrderList = [];
  List<OrderListDataModel> processingOrderList = [];
  List<OrderListDataModel> completeOrderList = [];

  Future<void> initializeData() async {
    initialLoading = true;
    notifyListeners();
    await getPendingOrder();
    await getProcessingOrder();
    await getCompleteOrder();
    initialLoading = false;
    notifyListeners();
  }

  Future<void> getPendingOrder() async {
    await _orderRepository
        .getOrderList(orderEndpoint: ApiEndpoint.pendingOrderList)
        .then((result) {
      if (result.isNotEmpty) {
        pendingOrderList = result;
      }
    });
  }

  Future<void> getProcessingOrder() async {
    await _orderRepository
        .getOrderList(orderEndpoint: ApiEndpoint.processingOrderList)
        .then((result) {
      if (result.isNotEmpty) {
        processingOrderList = result;
      }
    });
  }

  Future<void> getCompleteOrder() async {
    await _orderRepository
        .getOrderList(orderEndpoint: ApiEndpoint.completeOrderList)
        .then((result) {
      if (result.isNotEmpty) {
        completeOrderList = result;
      }
    });
  }
}
