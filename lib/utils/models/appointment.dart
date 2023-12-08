// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  String? uid;
  String? customerName;
  String? contactInformation;
  String? carDetails;
  String? washType;
  String? appointmentDateTime;
  String? status;                        //scheduled ,in progress, completed, canceled, waiting
  String? paymentInformation;
  String? specialRequests; //
  String? assignedWasher;

  
  Appointment({
    this.uid,
    this.customerName,
    this.contactInformation,
    this.carDetails,
    this.washType,
    this.appointmentDateTime,
    this.status,
    this.paymentInformation,
    this.specialRequests,
    this.assignedWasher,
  });

 

  

  String appointmentToJson() => json.encode(toJson());

  Appointment fromJson(String source) => Appointment.fromJson(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'customerName': customerName,
      'contactInformation': contactInformation,
      'carDetails': carDetails,
      'washType': washType,
      'appointmentDateTime': appointmentDateTime,
      'status': status,
      'paymentInformation': paymentInformation,
      'specialRequests': specialRequests,
      'assignedWasher': assignedWasher,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> map) {
    return Appointment(
      uid: map['uid'] != null ? map['uid'] as String : null,
      customerName: map['customerName'] != null ? map['customerName'] as String : null,
      contactInformation: map['contactInformation'] != null ? map['contactInformation'] as String : null,
      carDetails: map['carDetails'] != null ? map['carDetails'] as String : null,
      washType: map['washType'] != null ? map['washType'] as String : null,
      appointmentDateTime: map['appointmentDateTime'] != null ? map['appointmentDateTime'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      paymentInformation: map['paymentInformation'] != null ? map['paymentInformation'] as String : null,
      specialRequests: map['specialRequests'] != null ? map['specialRequests'] as String : null,
      assignedWasher: map['assignedWasher'] != null ? map['assignedWasher'] as String : null,
    );
  }


}
