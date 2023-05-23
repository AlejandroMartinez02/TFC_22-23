import 'dart:convert';

class WorkerDTO {
  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String maritalStatus;
  int? salary;
  String age;
  String role;
  String? password;

  WorkerDTO(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.email,
      required this.phone,
      required this.maritalStatus,
      required this.salary,
      required this.age,
      required this.role,
      this.password});

  WorkerDTO copyWith(
          {String? id,
          String? name,
          String? lastname,
          String? email,
          String? phone,
          String? maritalStatus,
          int? salary,
          String? age,
          String? role,
          String? password}) =>
      WorkerDTO(
          id: id ?? this.id,
          name: name ?? this.name,
          lastname: lastname ?? this.lastname,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          maritalStatus: maritalStatus ?? this.maritalStatus,
          salary: salary ?? this.salary,
          age: age ?? this.age,
          role: role ?? this.role);

  factory WorkerDTO.fromRawJson(String str) =>
      WorkerDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkerDTO.fromJson(Map<String, dynamic> json) => WorkerDTO(
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        maritalStatus: json["maritalStatus"],
        salary: json["salary"],
        age: json["age"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "maritalStatus": maritalStatus,
        "salary": salary.toString(),
        "age": age,
        "role": role,
        "password": password ?? ''
      };

  bool equals(WorkerDTO toCompare) {
    return name == toCompare.name &&
            lastname == toCompare.lastname &&
            email == toCompare.email &&
            phone == toCompare.phone &&
            maritalStatus == toCompare.maritalStatus &&
            salary == toCompare.salary &&
            age == toCompare.age &&
            role == toCompare.role
        ? true
        : false;
  }
}
