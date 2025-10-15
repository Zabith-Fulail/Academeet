import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_enum.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widget/app_text_field.dart';
import '../../widget/primary_app_button.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      // Perform sign-in logic here
      Navigator.pushNamed(context, Routes.kStudentHomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surfacePrimary,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
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
                        AppStrings.login,
                        style: size20weight600.copyWith(
                            color: colors(context).whiteColor),
                      ),
                      12.verticalSpace,
                      Text(
                        AppStrings.loginDes,
                        style: size20weight400.copyWith(
                            color: colors(context).whiteColor!.withValues(alpha: 0.4)),
                      ),
                      24.verticalSpace,
                      AppTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._-]'),
                          ),
                        ],
                        controller: _emailController,
                        labelText: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          // New, more comprehensive email regex
                          else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                              .hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      AppTextField(
                        controller: _passwordController,
                        labelText: "Password",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot password?',
                            style: size14weight400.copyWith(
                              color: colors(context).whiteColor,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      32.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: size16weight400.copyWith(
                                    color: colors(context).whiteColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "Sign up",
                                  style: size16weight400.copyWith(
                                    color: colors(context).buttonPrimaryColor,
                                  ),

                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigator.pushNamed(context, Routes.kSignUpView);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SafeArea(
                child: PrimaryAppButton(
                    title: AppStrings.login,
                    onTap: _signIn,
                    buttonType: ButtonType.Primary
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
