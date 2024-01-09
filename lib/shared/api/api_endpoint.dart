class ApiEndpoint {
  ///Base URL
  static const String baseUrl = 'https://restaurant2.bdhscanada.com';

  ///Auth
  static const String signIn = '/api/login';
  static const String signup = '/api/reg-owner';
  ///Home
  static const String dashboard = '/api/owner/dashboard/';
  ///Order
  static const String pendingOrder = '/api/owner/order-list/pending/';
  static const String processingOrder = '/api/owner/order-list/processing/';
  static const String completeOrder = '/api/owner/order-list/complete/';
}
