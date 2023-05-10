import 'dart:convert';

import 'product_dto.dart';

class OrderLine {
  String id;
  Product product;
  int count;
  double cost;

  OrderLine({
    required this.id,
    required this.product,
    required this.count,
    required this.cost,
  });

  OrderLine copyWith({
    String? id,
    Product? product,
    int? count,
    double? cost,
  }) =>
      OrderLine(
        id: id ?? this.id,
        product: product ?? this.product,
        count: count ?? this.count,
        cost: cost ?? this.cost,
      );

  factory OrderLine.fromRawJson(String str) =>
      OrderLine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
        id: json["_id"],
        product: Product.fromJson(json["product"]),
        count: json["count"],
        cost: json["cost"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product.toJson(),
        "count": count,
        "cost": cost,
      };
}
