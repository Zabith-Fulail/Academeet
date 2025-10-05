// To parse this JSON data, do
//
//     final verifyOtpResponse = verifyOtpResponseFromJson(jsonString);

import 'dart:convert';

VerifyOtpResponse verifyOtpResponseFromJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(VerifyOtpResponse data) => json.encode(data.toJson());

class VerifyOtpResponse {
  final String? token;
  final bool? customerExists;
  final bool? profileComplete;

  VerifyOtpResponse({
    this.token,
    this.customerExists,
    this.profileComplete,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => VerifyOtpResponse(
    token: json["token"],
    customerExists: json["customerExists"],
    profileComplete: json["profileComplete"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "customerExists": customerExists,
    "profileComplete": profileComplete,
  };
}
