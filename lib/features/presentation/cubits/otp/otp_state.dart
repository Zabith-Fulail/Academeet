part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class SendOtpInitial extends OtpState {}

class SendOtpSuccessState extends OtpState {
  final String message;
  final String phoneNumber;
  final String otp;

  SendOtpSuccessState({
    required this.message,
    required this.phoneNumber,
    required this.otp,
  });
}
class SendOtpFailedState extends OtpState {
  final String message;

  SendOtpFailedState({
    required this.message,
  });
}
class SendOtpLoadingState extends OtpState {

}

class VerifyOtpSuccessState extends OtpState {
  final bool? customerExists;
  final bool? profileComplete;

  VerifyOtpSuccessState({this.customerExists, this.profileComplete});
}
class VerifyOtpFailedState extends OtpState {
  final String message;

  VerifyOtpFailedState({
    required this.message,
  });
}
class VerifyOtpLoadingState extends OtpState {

}