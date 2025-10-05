// To parse this JSON data, do
//
//     final sendOtpRequest = sendOtpRequestFromJson(jsonString);

import 'dart:convert';

SendOtpRequest sendOtpRequestFromJson(String str) => SendOtpRequest.fromJson(json.decode(str));

String sendOtpRequestToJson(SendOtpRequest data) => json.encode(data.toJson());

class SendOtpRequest {
  final String? phoneNumber;
  final String? userRole;

  SendOtpRequest({
    this.phoneNumber,
    this.userRole,
  });

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) => SendOtpRequest(
    phoneNumber: json["phoneNumber"],
    userRole: json["userRole"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "userRole": userRole,
  };
}
