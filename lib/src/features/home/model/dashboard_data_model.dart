import 'dart:convert';

DashboardDataModel dashboardDataModelFromJson(String str) =>
    DashboardDataModel.fromJson(json.decode(str));

String dashboardDataModelToJson(DashboardDataModel data) =>
    json.encode(data.toJson());

class DashboardDataModel {
  final Data? data;

  DashboardDataModel({
    this.data,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? pendingOrder;
  final int? completeOrder;
  final int? totalOrder;
  final int? totalPayment;

  Data({
    this.pendingOrder,
    this.completeOrder,
    this.totalOrder,
    this.totalPayment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pendingOrder: json["pending_order"],
        completeOrder: json["complete_order"],
        totalOrder: json["total_order"],
        totalPayment: json["total_payment"],
      );

  Map<String, dynamic> toJson() => {
        "pending_order": pendingOrder,
        "complete_order": completeOrder,
        "total_order": totalOrder,
        "total_payment": totalPayment,
      };
}
