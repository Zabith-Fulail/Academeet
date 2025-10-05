// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

import '../common/error_response.dart';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) =>
    json.encode(data.toJson());

class ErrorResponseModel extends ErrorResponse {
  const ErrorResponseModel({
    this.errorCode,
    this.errorDescription,
  });

  final String? errorCode;
  final String? errorDescription;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        errorCode: json['errorCode']?.toString() ?? json['code']?.toString(),
        errorDescription: json['errorDescription'] ?? json['message'],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorDescription": errorDescription,
      };
}
