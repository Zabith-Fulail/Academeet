import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_styling.dart';

class GenderSelectionComponent extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final String title;
  final Color? color;
  final bool isFirstItem;
  final String? iconImage;

  const GenderSelectionComponent(
      {super.key,
      required this.onTap,
      this.icon,
      required this.title,
      required this.color,
      this.iconImage,
      this.isFirstItem = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(isFirstItem ? 16 : 0, 0, 8, 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // bottom shadow only
          BoxShadow(
            color: color!.withValues(alpha: 0.25),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(6, 6), // only bottom
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconImage != null ? SizedBox(height: 60, width: 45,child: SvgPicture.asset(iconImage!,),) : SizedBox(
              height: 60,
              width: 45,
              child: Icon(
                icon,
                color: color,
                size: 44,
              ),
            ),
            Text(
              title,
              style: AppStyling.text500Size15.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
