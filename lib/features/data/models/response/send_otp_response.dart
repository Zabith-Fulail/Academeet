// To parse this JSON data, do
//
//     final sendOtpResponse = sendOtpResponseFromJson(jsonString);

import 'dart:convert';

SendOtpResponse sendOtpResponseFromJson(String str) => SendOtpResponse.fromJson(json.decode(str));

String sendOtpResponseToJson(SendOtpResponse data) => json.encode(data.toJson());

class SendOtpResponse {
  final String? phoneNumber;
  final String? message;
  final String? otp;

  SendOtpResponse({
    this.phoneNumber,
    this.message,
    this.otp,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) => SendOtpResponse(
    phoneNumber: json["phoneNumber"],
    message: json["message"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "message": message,
    "otp": otp,
  };
}
