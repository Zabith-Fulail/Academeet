// To parse this JSON data, do
//
//     final saloonBranchesResponse = saloonBranchesResponseFromJson(jsonString);

import 'dart:convert';

List<SaloonBranchesResponse> saloonBranchesResponseFromJson(String str) => List<SaloonBranchesResponse>.from(json.decode(str).map((x) => SaloonBranchesResponse.fromJson(x)));

String saloonBranchesResponseToJson(List<SaloonBranchesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaloonBranchesResponse {
  final int? branchId;
  final String? branchName;
  final String? status;
  final double? longitude;
  final double? latitude;
  final String? branchPhoneNumber;
  final String? branchEmail;
  final String? description;
  final String? branchImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? salonType;

  SaloonBranchesResponse({
    this.branchId,
    this.branchName,
    this.status,
    this.longitude,
    this.latitude,
    this.branchPhoneNumber,
    this.branchEmail,
    this.description,
    this.branchImage,
    this.createdAt,
    this.updatedAt,
    this.salonType,
  });

  factory SaloonBranchesResponse.fromJson(Map<String, dynamic> json) => SaloonBranchesResponse(
    branchId: json["branchId"],
    branchName: json["branchName"],
    status: json["status"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    branchPhoneNumber: json["branchPhoneNumber"],
    branchEmail: json["branchEmail"],
    description: json["description"],
    branchImage: json["branchImage"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    salonType: json["salonType"],
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "branchName": branchName,
    "status": status,
    "longitude": longitude,
    "latitude": latitude,
    "branchPhoneNumber": branchPhoneNumber,
    "branchEmail": branchEmail,
    "description": description,
    "branchImage": branchImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "salonType": salonType,
  };
}
