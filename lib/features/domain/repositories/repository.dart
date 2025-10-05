import 'package:dartz/dartz.dart';
import '../../../error/failures.dart';
import '../../data/models/request/send_otp_request.dart';
import '../../data/models/request/verify_otp_request.dart';
import '../../data/models/response/promotions_response.dart';
import '../../data/models/response/send_otp_response.dart';
import '../../data/models/response/verify_otp_response.dart';

abstract class Repository {
  Future<Either<Failure, SendOtpResponse>> sendOtpRequest(
      SendOtpRequest sendOtpRequest);

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      VerifyOtpRequest verifyOtp);

  Future<Either<Failure, List<PromotionsResponse>>> getPromotions();
}