import 'dart:convert';

import 'order_line_dto.dart';

class OrderDTO {
  String id;
  DateTime date;
  double totalCost;
  String userId;
  List<OrderLine> orderLines;
  String state;
  int v;

  OrderDTO({
    required this.id,
    required this.date,
    required this.totalCost,
    required this.userId,
    required this.orderLines,
    required this.state,
    required this.v,
  });

  OrderDTO copyWith({
    String? id,
    DateTime? date,
    double? totalCost,
    String? userId,
    List<OrderLine>? orderLines,
    String? state,
    int? v,
  }) =>
      OrderDTO(
        id: id ?? this.id,
        date: date ?? this.date,
        totalCost: totalCost ?? this.totalCost,
        userId: userId ?? this.userId,
        orderLines: orderLines ?? this.orderLines,
        state: state ?? this.state,
        v: v ?? this.v,
      );

  factory OrderDTO.fromRawJson(String str) =>
      OrderDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDTO.fromJson(Map<String, dynamic> json) => OrderDTO(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        totalCost: json["total_cost"]?.toDouble(),
        userId: json["userId"],
        orderLines: List<OrderLine>.from(
            json["order_lines"].map((x) => OrderLine.fromJson(x))),
        state: json["state"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date.toIso8601String(),
        "total_cost": totalCost,
        "userId": userId,
        "order_lines": List<dynamic>.from(orderLines.map((x) => x.toJson())),
        "state": state,
        "__v": v,
      };
}
