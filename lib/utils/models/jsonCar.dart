// To parse this JSON data, do
//
//     final jsonCar = jsonCarFromJson(jsonString);

import 'dart:convert';

List<JsonCar> jsonCarFromJson(String str) => List<JsonCar>.from(json.decode(str).map((x) => JsonCar.fromJson(x)));

String jsonCarToJson(List<JsonCar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonCar {
    String? brand;
    List<String>? models;

    JsonCar({
        this.brand,
        this.models,
    });

    factory JsonCar.fromJson(Map<String, dynamic> json) => JsonCar(
        brand: json["brand"],
        models: json["models"] == null ? [] : List<String>.from(json["models"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "brand": brand,
        "models": models == null ? [] : List<dynamic>.from(models!.map((x) => x)),
    };
}
