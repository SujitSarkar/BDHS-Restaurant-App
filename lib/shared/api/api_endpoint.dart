class ApiEndpoint {
  ///Base URL
  static const String baseUrl = 'https://restaurant2.bdhscanada.com';

  ///Auth
  static const String signIn = '/api/login';
  static const String signup = '/api/reg-owner';
  ///Home
  static const String dashboard = '/api/owner/dashboard/';
  ///Order
  static const String pendingOrderList = '/api/owner/order-list/pending/';
  static const String processingOrderList = '/api/owner/order-list/processing/';
  static const String completeOrderList = '/api/owner/order-list/complete/';
  ///Order Action
  static const String orderReady = '/api/owner/order/ready/';
  static const String cancelOrder = '/api/owner/order/cancel/';
  static const String processingOrder = '/api/owner/order/processing/';
}
