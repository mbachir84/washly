// To parse this JSON data, do
//
//     final carRequest = carRequestFromJson(jsonString);

import 'dart:convert';

import 'package:washly/utils/models/w_user.dart';

CarRequest carRequestFromJson(String str) => CarRequest.fromJson(json.decode(str));

String carRequestToJson(CarRequest data) => json.encode(data.toJson());

class CarRequest {
    WUser? wUser;
    String? model;
    String? make;
    String? uid;

    CarRequest({
        this.wUser,
        this.model,
        this.make,
        this.uid,
    });

    factory CarRequest.fromJson(Map<String, dynamic> json) => CarRequest(
        wUser: json["w_user"] == null ? null : WUser.fromJson(json["w_user"]),
        model: json["model"],
        make: json["make"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "w_user": wUser?.toJson(),
        "model": model,
        "make": make,
        "uid": uid,
    };
}
 