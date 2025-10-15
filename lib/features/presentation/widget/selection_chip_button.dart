import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionChipButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const SelectionChipButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<SelectionChipButton> createState() => _SelectionChipButtonState();
}

class _SelectionChipButtonState extends State<SelectionChipButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,0,16,12).w,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: widget.onTap,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16).w,
          decoration: BoxDecoration(
            color: Color(0xFF2A2935),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: size14weight400.copyWith(color: colors(context).whiteColor),
          ),
        ),
      ),
    );
  }
}
