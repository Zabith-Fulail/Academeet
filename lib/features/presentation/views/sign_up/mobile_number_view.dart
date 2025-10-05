import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/utils/app_strings.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_enum.dart';
import '../../../../utils/navigation_routes.dart';
import '../../cubits/otp/otp_cubit.dart';
import '../../widget/app_text_field.dart';
import '../../widget/primary_app_button.dart';
import '../otp_verification/data/otp_verify_view_args.dart';

class MobileNumberView extends StatefulWidget {
  const MobileNumberView({super.key});

  @override
  State<MobileNumberView> createState() => _MobileNumberViewState();
}

class _MobileNumberViewState extends State<MobileNumberView> {
  Country selectedCountry = Country.parse('LK'); // Default Sri Lanka
  final TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String get fullPhoneNumber =>
      '+${selectedCountry.phoneCode}${mobileController.text}';


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OtpCubit>(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is SendOtpSuccessState) {
            // Navigate to OTP verify view
            Navigator.pushNamed(
              context,
              Routes.kOtpVerifyView,
              arguments: OtpVerifyViewArgs(
                otpID: state.otp,
                phoneNumber: state.phoneNumber
              )
            );
          } else if (state is SendOtpFailedState) {
            // Show dialog for error
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
          final isLoading = state is SendOtpLoadingState;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: colors(context).surfacePrimary,
                body: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 110),
                                Text(
                                  AppStrings.mobileNumber,
                                  style: size20weight700.copyWith(color: colors(context).whiteColor),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  AppStrings.mobileNumberDes,
                                  style: size16weight400.copyWith(color: colors(context).whiteColor!.withValues(alpha: 0.4))
                                ),
                                const SizedBox(height: 72),
                                AppTextField(
                                  textInputAction: TextInputAction.done,
                                  controller: mobileController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  labelText: "Mobile Number",
                                  maxLength: 10,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your mobile number";
                                    } else if (value.length != 10) {
                                      return "Mobile number must be 9 digits (07x xx xx xxx)";
                                    } else if (!value.startsWith('07')) {
                                      return "Mobile number must start with 07";
                                    }
                                    return null;
                                  },
                                ),
                                // SizedBox(
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       GestureDetector(
                                //         onTap: _selectCountry,
                                //         child: Container(
                                //           height: 58,
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 12, vertical: 14),
                                //           decoration: BoxDecoration(
                                //             border: Border.all(
                                //                 color:
                                //                 colors(context).whiteColor!),
                                //             borderRadius: BorderRadius.circular(8),
                                //             color: colors(context).surfacePrimary,
                                //           ),
                                //           child: Row(
                                //             children: [
                                //               Text(
                                //                 '${selectedCountry.flagEmoji} ',
                                //                 style: size14weight700.copyWith(color: colors(context).whiteColor),
                                //               ),
                                //               Text(
                                //                 '+${selectedCountry.phoneCode}',
                                //                 style: size14weight400.copyWith(color: colors(context).whiteColor),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //       const SizedBox(width: 12),
                                //       Expanded(
                                //         child: AppTextField(
                                //           textInputAction: TextInputAction.done,
                                //           controller: mobileController,
                                //           keyboardType: TextInputType.phone,
                                //           inputFormatters: [
                                //             FilteringTextInputFormatter.digitsOnly,
                                //           ],
                                //           labelText: "Mobile Number",
                                //           maxLength: 9,
                                //           validator: (value) {
                                //             if (value == null || value.isEmpty) {
                                //               return "Please enter your mobile number";
                                //             } else if (value.length != 9) {
                                //               return "Mobile number must be 9 digits (7x xx xx xxx)";
                                //             } else if (!value.startsWith('7')) {
                                //               return "Mobile number must start with 7";
                                //             }
                                //             return null;
                                //           },
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                        SafeArea(
                          child: PrimaryAppButton(
                            title: "CONTINUE",
                            buttonType: ButtonType.Primary,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // context.read<OtpCubit>().sendOtp(
                                //     phoneNumber: phoneNumber,
                                //     userRole: AppConstants.userRole
                                // );
                                Navigator.pushNamed(
                                    context,
                                    Routes.kOtpVerifyView,
                                    arguments: OtpVerifyViewArgs(
                                        otpID: "",
                                        phoneNumber: ""
                                    )
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
