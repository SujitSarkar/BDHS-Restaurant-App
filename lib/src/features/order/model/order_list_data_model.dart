import 'dart:convert';

List<OrderListDataModel> orderListDataModelFromJson(String str) => List<OrderListDataModel>.from(json.decode(str).map((x) => OrderListDataModel.fromJson(x)));

class OrderListDataModel {
  final int? id;
  final String? customer;
  final String? restaurant;
  final List<OrderDetl>? orderDetl;
  final DeliveryAddress? deliveryAddress;
  final Payment? payment;

  OrderListDataModel({
    this.id,
    this.customer,
    this.restaurant,
    this.orderDetl,
    this.deliveryAddress,
    this.payment,
  });

  factory OrderListDataModel.fromJson(Map<String, dynamic> json) => OrderListDataModel(
    id: json["id"],
    customer: json["customer"],
    restaurant: json["restaurant"],
    orderDetl: json["order_detl"] == null ? [] : List<OrderDetl>.from(json["order_detl"]!.map((x) => OrderDetl.fromJson(x))),
    deliveryAddress: json["delivery_address"] == null ? null : DeliveryAddress.fromJson(json["delivery_address"]),
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
  );
}

class DeliveryAddress {
  final int? id;
  final String? address;
  final dynamic latitude;
  final dynamic longitude;

  DeliveryAddress({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
    id: json["id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

}

class OrderDetl {
  final String? foodId;
  final String? userId;
  final String? quantity;
  final String? pricePerQty;

  OrderDetl({
    this.foodId,
    this.userId,
    this.quantity,
    this.pricePerQty,
  });

  factory OrderDetl.fromJson(Map<String, dynamic> json) => OrderDetl(
    foodId: json["food_id"],
    userId: json["user_id"],
    quantity: json["quantity"],
    pricePerQty: json["price_per_qty"],
  );
}

class Payment {
  final int? id;
  final String? total;
  final String? discount;
  final String? deliveryFee;
  final String? payable;

  Payment({
    this.id,
    this.total,
    this.discount,
    this.deliveryFee,
    this.payable,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    total: json["total"],
    discount: json["discount"],
    deliveryFee: json["delivery_fee"],
    payable: json["payable"],
  );
  
}
