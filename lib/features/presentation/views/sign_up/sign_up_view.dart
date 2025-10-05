import 'package:academeet/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_enum.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widget/app_text_field.dart';
import '../../widget/primary_app_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surfacePrimary,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
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
                AppStrings.signUp,
                style: size20weight600.copyWith(
                    color: colors(context).whiteColor),
              ),
              12.verticalSpace,
              Text(
                AppStrings.signUpDes,
                style: size20weight400.copyWith(
                    color: colors(context).whiteColor!.withValues(alpha: 0.4)),
              ),
              24.verticalSpace,
              AppTextField(
                textInputAction: TextInputAction.next,
                labelText: AppStrings.username
              ),
              AppTextField(
                textInputAction: TextInputAction.next,
                labelText: "Password",
              ),
              AppTextField(
                textInputAction: TextInputAction.done,
                labelText: "Confirm Password",
              ),
              PrimaryAppButton(
                title: "SIGN UP",
                buttonType: ButtonType.Primary,
                onTap: () {
                  Navigator.pushNamed(context, Routes.kMobileNumberView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
