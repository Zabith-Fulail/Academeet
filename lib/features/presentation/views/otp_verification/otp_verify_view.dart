import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_enum.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/navigation_routes.dart';
import '../../cubits/otp/otp_cubit.dart';
import '../../widget/primary_app_button.dart';
import 'data/otp_verify_view_args.dart';

class OtpVerifyView extends StatefulWidget {
  final OtpVerifyViewArgs otpVerifyViewArgs;

  const OtpVerifyView({super.key, required this.otpVerifyViewArgs});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: colors(context).surfacePrimary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors(context).whiteColor!),
        color: colors(context).surfacePrimary,
      ),
    );

    return BlocProvider(
      create: (_) => sl<OtpCubit>(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccessState) {
            // OTP Sent Successfully
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   Routes.kGenderSelectionView,
            //       (route) => false,
            // );
          } else if (state is VerifyOtpFailedState) {
            // Show error message
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is VerifyOtpLoadingState;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: colors(context).surfacePrimary,
                body: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              48.verticalSpace,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(AppAssets.iconBook, height: 58, width: 32,),
                                  12.horizontalSpace,
                                  Text(
                                    AppStrings.appName,
                                    style: size24weight700.copyWith(
                                        color: colors(context).darkGreen),
                                  ),
                                ],
                              ),
                              56.verticalSpace,
                              Text(
                                AppStrings.verifyOTP,
                                style: size20weight600.copyWith(
                                    color: colors(context).whiteColor),
                              ),
                              12.verticalSpace,
                              Text(
                                AppStrings.verifyOTPDes,
                                style: size20weight400.copyWith(
                                    color: colors(context).whiteColor!.withValues(alpha: 0.4)),
                              ),
                              56.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Pinput(
                                    length: 4,
                                    controller: otpController,
                                    focusNode: _otpFocusNode,
                                    defaultPinTheme: defaultPinTheme,
                                    keyboardType: TextInputType.number,
                                    focusedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!.copyWith(
                                        border: Border.all(color: colors(context).buttonPrimaryColor!),
                                      ),
                                    ),
                                    submittedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!.copyWith(
                                        color: colors(context).buttonPrimaryColor,
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    animationCurve: Curves.easeInOut,
                                    onCompleted: (pin) {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: PrimaryAppButton(
                          title: "VERIFY",
                          buttonType: ButtonType.Primary,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.kLogInView);
                            // context.read<OtpCubit>().verifyOtp(
                            //   phoneNumber: widget.otpVerifyViewArgs.phoneNumber,
                            //   otp: otpController.text.trim(),
                            //   userRole: AppConstants.userRole,
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
