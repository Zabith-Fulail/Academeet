// To parse this JSON data, do
//
//     final verifyOtpRequest = verifyOtpRequestFromJson(jsonString);

import 'dart:convert';

VerifyOtpRequest verifyOtpRequestFromJson(String str) => VerifyOtpRequest.fromJson(json.decode(str));

String verifyOtpRequestToJson(VerifyOtpRequest data) => json.encode(data.toJson());

class VerifyOtpRequest {
  final String? phoneNumber;
  final String? otp;
  final String? userRole;

  VerifyOtpRequest({
    this.phoneNumber,
    this.otp,
    this.userRole,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) => VerifyOtpRequest(
    phoneNumber: json["phoneNumber"],
    otp: json["otp"],
    userRole: json["userRole"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "otp": otp,
    "userRole": userRole,
  };
}
