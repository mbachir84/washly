// To parse this JSON data, do
//
//     final wUser = wUserFromJson(jsonString);

import 'dart:convert';

import 'package:washly/utils/models/address.dart';

WUser wUserFromJson(String str) => WUser.fromJson(json.decode(str));

String wUserToJson(WUser data) => json.encode(data.toJson());

class WUser {
  String? uid;
  String? fullname;
  String? phoneNumber;
  bool? isWasher;
  String? currentPage;
  CreditCard? creditCard;
  String? profileImage;
  String? payType;
  String? email;
  List<Address>? addresses;
  bool? isVerified;
  bool? isActivated;
  int? totalCourses;
  int? totalRatings;
  bool? isDeleted;
  String? createdAt;
  List<Car> cars;

  WUser({
    this.uid,
    this.fullname,
    this.phoneNumber,
    this.isWasher,
    this.currentPage,
    this.creditCard,
    this.payType,
    this.email,
    this.addresses,
    this.isVerified,
    this.profileImage,
    this.isActivated,
    this.totalCourses,
    this.totalRatings,
    this.isDeleted,
    this.createdAt,
    this.cars = const [],
  });

  factory WUser.fromJson(Map<String, dynamic> json) => WUser(
        uid: json["uid"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        isWasher: json["isWasher"],
        currentPage: json["current_page"],
        creditCard: json["credit_card"] == null
            ? null
            : CreditCard.fromJson(json["credit_card"]),
        payType: json["pay_type"],
        email: json["email"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
        isVerified: json["is_verified"],
        isActivated: json["is_activated"],
        totalCourses: json["total_courses"],
        profileImage: json["profile_image"],
        totalRatings: json["total_ratings"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"],
        cars: json["cars"] == null
            ? []
            : List<Car>.from(json["cars"]!.map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "isWasher": isWasher,
        "current_page": currentPage,
        "credit_card": creditCard?.toJson(),
        "pay_type": payType,
        "email": email,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "is_verified": isVerified,
        "is_activated": isActivated,
        "profile_image": profileImage,
        "total_courses": totalCourses,
        "total_ratings": totalRatings,
        "is_deleted": isDeleted,
        "created_at": createdAt,
        "cars":
            cars == null ? [] : List<dynamic>.from(cars.map((x) => x.toJson())),
      };
}

// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String? uid;
  int? cityMpg;
  String? licencePlate;
  String? carClass;
  String? make;
  String? model;
  String? image;
  bool? isSelected;

  Car({
    this.uid,
    this.cityMpg,
    this.licencePlate,
    this.carClass,
    this.make,
    this.model,
    this.image,
    this.isSelected,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        uid: json["uid"],
        cityMpg: json["city_mpg"],
        licencePlate: json["licence_plate"],
        carClass: json["class"],
        make: json["make"],
        model: json["model"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "city_mpg": cityMpg,
        "licence_plate": licencePlate,
        "class": carClass,
        "make": make,
        "model": model,
        "image": image,
      };
}

class CreditCard {
  String? cardNumber;
  String? cardholder;
  String? expiryDate;

  CreditCard({
    this.cardNumber,
    this.cardholder,
    this.expiryDate,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
        cardNumber: json["card_number"],
        cardholder: json["cardholder"],
        expiryDate: json["expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "card_number": cardNumber,
        "cardholder": cardholder,
        "expiry_date": expiryDate,
      };
}
