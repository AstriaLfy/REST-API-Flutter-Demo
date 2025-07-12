import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final List<Result> results;

  Product({
    required this.results,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;

  Result({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    cell: json["cell"],
    nat: json["nat"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "email": email,
    "phone": phone,
    "cell": cell,
    "nat": nat,
  };
}
