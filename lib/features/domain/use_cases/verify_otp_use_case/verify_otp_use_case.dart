import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/request/verify_otp_request.dart';
import '../../../data/models/response/verify_otp_response.dart';
import '../../repositories/repository.dart';
class VerifyOtpUseCase {
  final Repository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, VerifyOtpResponse>> call(
      VerifyOtpRequest verifyOtp) async {
    return await repository.verifyOtp(verifyOtp);
  }
}
