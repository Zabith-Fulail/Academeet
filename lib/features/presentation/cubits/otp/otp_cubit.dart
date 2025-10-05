import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../error/error_messages.dart';
import '../../../../error/failures.dart';
import '../../../data/data_sources/local_data_sources.dart';
import '../../../data/models/request/send_otp_request.dart';
import '../../../data/models/request/verify_otp_request.dart';
import '../../../domain/use_cases/send_otp/send_otp_use_case.dart';
import '../../../domain/use_cases/verify_otp_use_case/verify_otp_use_case.dart';

part 'otp_state.dart';
class OtpCubit extends Cubit<OtpState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final LocalDataSource source;
  OtpCubit({required this.sendOtpUseCase,required this.verifyOtpUseCase,required this.source,}) : super(SendOtpInitial());

  Future<void> sendOtp({required String phoneNumber, required String userRole}) async {
    emit(SendOtpLoadingState());
    final response = await sendOtpUseCase(
      SendOtpRequest(phoneNumber: phoneNumber, userRole: userRole),
    );
    response.fold(
      (failure) {
        if(failure is ConnectionFailure){
          emit(SendOtpFailedState(message: ErrorMessages().mapFailureToMessage(failure) ?? ""));
        }else if(failure is AuthorizedFailure) {
          emit(SendOtpFailedState(message: 'Unauthorized. Please login again.'));
          return;
        }else if (failure is ServerFailure){
          emit(SendOtpFailedState(message: failure.errorResponse.errorDescription ?? "Something went wrong. Please try again"));
        }else {
          emit(SendOtpFailedState(message: "Something went wrong. Please try again"));
        }

      },
      (data) {
        emit(SendOtpSuccessState(message: data.message ?? 'OTP sent successfully', otp: data.otp ?? '', phoneNumber: data.phoneNumber ?? ''));
      },
    );
  }

  Future<void> verifyOtp({required String phoneNumber, required String otp, required String userRole}) async {
    emit(VerifyOtpLoadingState());
    final response = await verifyOtpUseCase(
      VerifyOtpRequest(phoneNumber: phoneNumber, userRole: userRole, otp: otp),
    );
    response.fold(
      (failure) {
        if(failure is ConnectionFailure){
          emit(VerifyOtpFailedState(message: ErrorMessages().mapFailureToMessage(failure) ?? ""));
        }else if(failure is AuthorizedFailure) {
          emit(VerifyOtpFailedState(message: 'Unauthorized. Please login again.'));
          return;
        }else if (failure is ServerFailure){
          emit(VerifyOtpFailedState(message: failure.errorResponse.errorDescription ?? "Something went wrong. Please try again"));
        }else {
          emit(VerifyOtpFailedState(message: "Something went wrong. Please try again"));
        }

      },
      (data) {
        source.setAccessToken(data.token);
        emit(VerifyOtpSuccessState(customerExists: data.customerExists, profileComplete: data.profileComplete));
      },
    );
  }
}
