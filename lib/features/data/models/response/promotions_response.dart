// To parse this JSON data, do
//
//     final promotionsResponse = promotionsResponseFromJson(jsonString);

import 'dart:convert';

List<PromotionsResponse> promotionsResponseFromJson(String str) => List<PromotionsResponse>.from(json.decode(str).map((x) => PromotionsResponse.fromJson(x)));

String promotionsResponseToJson(List<PromotionsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromotionsResponse {
  final int? promotionId;
  final String? promotionName;
  final String? description;
  final String? imageUrl;
  final String? status;

  PromotionsResponse({
    this.promotionId,
    this.promotionName,
    this.description,
    this.imageUrl,
    this.status,
  });

  factory PromotionsResponse.fromJson(Map<String, dynamic> json) => PromotionsResponse(
    promotionId: json["promotionId"],
    promotionName: json["promotionName"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "promotionId": promotionId,
    "promotionName": promotionName,
    "description": description,
    "imageUrl": imageUrl,
    "status": status,
  };
}
