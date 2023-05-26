import 'dart:convert';

import '../../data/network/response/table_dto.dart';
import 'order_line_dto.dart';

class OrderDTO {
  DateTime date = DateTime.now().toLocal();
  double totalCost;
  List<OrderLineDTO> orderLines;
  String state;
  TableDTO? table;

  OrderDTO(
      {required this.date,
      required this.totalCost,
      required this.orderLines,
      required this.state,
      this.table});

  OrderDTO copyWith({
    DateTime? date,
    double? totalCost,
    List<OrderLineDTO>? orderLines,
    String? state,
  }) =>
      OrderDTO(
        date: date ?? this.date,
        totalCost: totalCost ?? this.totalCost,
        orderLines: orderLines ?? this.orderLines,
        state: state ?? this.state,
      );

  factory OrderDTO.fromRawJson(String str) =>
      OrderDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDTO.fromJson(Map<String, dynamic> json) => OrderDTO(
      date: DateTime.parse(json["date"]),
      totalCost: json["total_cost"]?.toDouble(),
      orderLines: List<OrderLineDTO>.from(
          json["order_lines"].map((x) => OrderLineDTO.fromJson(x))),
      state: json["state"],
      table: TableDTO.fromJson(json["table"]));

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "total_cost": totalCost.toStringAsFixed(2),
        "order_lines": List<dynamic>.from(orderLines.map((x) => x.toJson())),
        "state": state,
        "table": table?.toJson()
      };
}
