import 'dart:convert';

import 'product_dto.dart';

class OrderLineDTO {
  String id;
  Product product;
  int count;
  double cost;

  OrderLineDTO({
    required this.id,
    required this.product,
    required this.count,
    required this.cost,
  });

  OrderLineDTO copyWith({
    String? id,
    Product? product,
    int? count,
    double? cost,
  }) =>
      OrderLineDTO(
        id: id ?? this.id,
        product: product ?? this.product,
        count: count ?? this.count,
        cost: cost ?? this.cost,
      );

  factory OrderLineDTO.fromRawJson(String str) =>
      OrderLineDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderLineDTO.fromJson(Map<String, dynamic> json) => OrderLineDTO(
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
