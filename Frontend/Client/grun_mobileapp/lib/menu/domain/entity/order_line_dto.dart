import 'dart:convert';

import '../../../../main/domain/entity/products_dto.dart';

class OrderLineDTO {
  ProductDTO product;
  int count;
  double cost;

  OrderLineDTO({
    required this.product,
    required this.count,
    required this.cost,
  });

  OrderLineDTO copyWith({
    String? id,
    ProductDTO? product,
    int? count,
    double? cost,
  }) =>
      OrderLineDTO(
        product: product ?? this.product,
        count: count ?? this.count,
        cost: cost ?? this.cost,
      );

  factory OrderLineDTO.fromRawJson(String str) =>
      OrderLineDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderLineDTO.fromJson(Map<String, dynamic> json) => OrderLineDTO(
        product: ProductDTO.fromJson(json["product"]),
        count: json["count"],
        cost: json["cost"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "count": count,
        "cost": cost,
      };
}
