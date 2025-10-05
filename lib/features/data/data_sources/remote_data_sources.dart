

import '../../../core/network/api_helper.dart';
import '../models/request/send_otp_request.dart';
import '../models/request/verify_otp_request.dart';
import '../models/response/promotions_response.dart';
import '../models/response/send_otp_response.dart';
import '../models/response/verify_otp_response.dart';

abstract class RemoteDataSource {
  Future<SendOtpResponse> sendOtpRequest(SendOtpRequest sendOtpRequest);
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest verifyOtpRequest);
  Future<List<PromotionsResponse>> getPromotions();
}
class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiHelper apiHelper;

  RemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<SendOtpResponse> sendOtpRequest(SendOtpRequest sendOtpRequest) async {
    try {
      final response = await apiHelper.post(
        "api/mobile/auth/send-otp",
        data: sendOtpRequest.toJson(),
      );
      return SendOtpResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest verifyOtpRequest) async {
    try {
      final response = await apiHelper.post(
        "api/mobile/auth/verify-otp",
        data: verifyOtpRequest.toJson(),
      );
      return VerifyOtpResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<PromotionsResponse>> getPromotions() async {
    final response = await apiHelper.get("api/mobile/promotions");

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => PromotionsResponse.fromJson(json)).toList();
  }
}