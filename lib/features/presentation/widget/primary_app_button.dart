import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/theme_data.dart';
import '../../../utils/app_enum.dart';

class PrimaryAppButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final ButtonType buttonType;
  final double? width;

  const PrimaryAppButton({
    super.key,
    required this.title,
    required this.buttonType,
    this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        // height: 45,
        width: width ?? double.maxFinite,
        padding: EdgeInsets.all(buttonType == ButtonType.Outline ? 8 : 12),
        decoration: BoxDecoration(
          color: getButtonColor(context, buttonType),
          borderRadius:
              BorderRadius.circular(buttonType == ButtonType.Outline ? 2 : 10),
          border: buttonType == ButtonType.Outline
              ? Border.all(color: colors(context).primaryTextColor!)
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: size16weight700.copyWith(
              color: colors(context).blackColor,)
          ),
        ),
      ),
    );
  }

  Color getButtonColor(context, buttonType) {
    switch (buttonType) {
      case ButtonType.Primary:
        return Color(0xFFC7FF85);
        // return colors(context).buttonPrimaryColor!;
      case ButtonType.Secondary:
        return colors(context).buttonPrimaryColor!;
      case ButtonType.Outline:
        return Colors.transparent;
      default:
        return colors(context).buttonPrimaryColor!;
    }
  }
}
