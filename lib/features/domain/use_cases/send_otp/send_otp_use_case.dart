import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/request/send_otp_request.dart';
import '../../../data/models/response/send_otp_response.dart';
import '../../repositories/repository.dart';

class SendOtpUseCase {
  final Repository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, SendOtpResponse>> call(
      SendOtpRequest sendOtpRequest) async {
    return await repository.sendOtpRequest(sendOtpRequest);
  }
}
