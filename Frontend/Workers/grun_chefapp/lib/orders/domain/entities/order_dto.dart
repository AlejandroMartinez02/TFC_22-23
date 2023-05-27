import 'dart:convert';

class OrderDTO {
  String id;
  DateTime date;
  double totalCost;
  List<OrderLine> orderLines;
  String state;
  Table? table;

  OrderDTO({
    required this.id,
    required this.date,
    required this.totalCost,
    required this.orderLines,
    required this.state,
    this.table,
  });

  OrderDTO copyWith(
          {String? id,
          DateTime? date,
          double? totalCost,
          List<OrderLine>? orderLines,
          Table? table,
          String? state}) =>
      OrderDTO(
        id: id ?? this.id,
        date: date ?? this.date,
        totalCost: totalCost ?? this.totalCost,
        orderLines: orderLines ?? this.orderLines,
        state: state ?? this.state,
        table: table ?? this.table,
      );

  factory OrderDTO.fromRawJson(String str) =>
      OrderDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDTO.fromJson(Map<String, dynamic> json) => OrderDTO(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        totalCost: json["total_cost"]?.toDouble(),
        orderLines: List<OrderLine>.from(
            json["order_lines"].map((x) => OrderLine.fromJson(x))),
        state: json["state"],
        table: json["table"] == null ? null : Table.fromJson(json["table"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "state": state,
        "table": table?.toJson(),
      };
}

class OrderLine {
  String id;
  double cost;
  int count;
  Product product;
  bool isDone = false;

  OrderLine({
    required this.id,
    required this.cost,
    required this.count,
    required this.product,
  });

  OrderLine copyWith({
    String? id,
    double? cost,
    int? count,
    Product? product,
  }) =>
      OrderLine(
        id: id ?? this.id,
        cost: cost ?? this.cost,
        count: count ?? this.count,
        product: product ?? this.product,
      );

  factory OrderLine.fromRawJson(String str) =>
      OrderLine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
        id: json["_id"],
        cost: json["cost"]?.toDouble(),
        count: json["count"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cost": cost.toStringAsFixed(2),
        "count": count.toString(),
        "product": product.toJson(),
      };
}

class Product {
  String id;
  String name;
  String ingredients;
  double cost;
  String photo;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.cost,
    required this.photo,
    required this.description,
  });

  Product copyWith({
    String? id,
    String? name,
    String? ingredients,
    double? cost,
    String? photo,
    String? description,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredients: ingredients ?? this.ingredients,
        cost: cost ?? this.cost,
        photo: photo ?? this.photo,
        description: description ?? this.description,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        ingredients: json["ingredients"],
        cost: json["cost"]?.toDouble(),
        photo: json["photo"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ingredients": ingredients,
        "cost": cost.toStringAsFixed(2),
        "photo": photo,
        "description": description,
      };
}

class Table {
  String id;
  int tableNumber;
  bool isInUse;

  Table({
    required this.id,
    required this.tableNumber,
    required this.isInUse,
  });

  Table copyWith({
    String? id,
    int? tableNumber,
    bool? isInUse,
  }) =>
      Table(
        id: id ?? this.id,
        tableNumber: tableNumber ?? this.tableNumber,
        isInUse: isInUse ?? this.isInUse,
      );

  factory Table.fromRawJson(String str) => Table.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["_id"],
        tableNumber: json["tableNumber"],
        isInUse: json["isInUse"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tableNumber": tableNumber,
        "isInUse": isInUse,
      };
}
