// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
    String? uid;
    String? name;
    String? description;
    bool? isDefault;
    double? latitude;
    double? longitude;


    Address({
        this.uid,
        this.name,
        this.description,
        this.isDefault,
        this.latitude,
        this.longitude,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        uid: json["uid"],
        name: json["name"],
        description: json["description"],
        isDefault: json["is_default"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "description": description,
        "is_default": isDefault,
        "latitude": latitude,
        "longitude": longitude,
    };
}
