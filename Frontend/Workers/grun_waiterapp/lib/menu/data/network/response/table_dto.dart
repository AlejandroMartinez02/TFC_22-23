import 'dart:convert';

class TableDTO {
  String id;
  int tableNumber;
  bool isInUse;

  TableDTO({
    required this.id,
    required this.tableNumber,
    required this.isInUse,
  });

  TableDTO copyWith({
    String? id,
    int? tableNumber,
    bool? isInUse,
  }) =>
      TableDTO(
        id: id ?? this.id,
        tableNumber: tableNumber ?? this.tableNumber,
        isInUse: isInUse ?? this.isInUse,
      );

  factory TableDTO.fromRawJson(String str) =>
      TableDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TableDTO.fromJson(Map<String, dynamic> json) => TableDTO(
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
