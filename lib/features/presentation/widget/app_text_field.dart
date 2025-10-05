import 'package:academeet/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/theme_data.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool? obscureText;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.controller,
    this.validator,
    this.labelText,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText ?? "",style: size14weight700.copyWith(color: colors(context).darkGreen),),
            8.verticalSpace,
            TextFormField(
              controller: controller,
              style: size14weight400.copyWith(color: colors(context).whiteColor),
              textInputAction: textInputAction,
              maxLength: maxLength,
              buildCounter: (
                  BuildContext context, {
                    required int currentLength,
                    required int? maxLength,
                    required bool isFocused,
                  }) {
                return null; // Completely removes the counter widget
              },
              decoration: InputDecoration(
                hintText: labelText,
                hintStyle: TextStyle(
                  color: colors(context).whiteColor!.withValues(alpha: 0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colors(context).darkGreen!,
                    style: BorderStyle.solid
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colors(context).whiteColor!,
                    style: BorderStyle.solid
                  )
                ),
                labelStyle: TextStyle(
                  color: colors(context).whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: colors(context).surfacePrimary,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colors(context).darkGreen!,
                    style: BorderStyle.solid
                  )
                ),
              ),
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              cursorColor: colors(context).darkGreen,
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}
