import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../widget/selection_chip_button.dart';
import 'language_selection_view.dart';

class LevelSelectionView extends StatefulWidget {
  final LanguageEntity selectedLanguage;

  const LevelSelectionView({super.key, required this.selectedLanguage});

  @override
  State<LevelSelectionView> createState() => _LevelSelectionViewState();
}

class _LevelSelectionViewState extends State<LevelSelectionView> {
  List<LevelEntity> languages = [
    LevelEntity(name: "O/L", code: "1"),
    LevelEntity(name: "A/L", code: "2"),
    LevelEntity(name: "Diplomas", code: "3"),
    LevelEntity(name: "Diplomas", code: "3"),
  ];
  LevelEntity? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          60.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).w,
            child: Text(
              "Find Tutor",
              style: size20weight700.copyWith(color: colors(context).darkGreen),
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).w,
            child: Row(
              children: [
                Text(
                  "Select Level",
                  style: size20weight700.copyWith(
                    color: colors(context).whiteColor,
                  ),
                ),
                8.horizontalSpace,
                Image.asset(AppAssets.icGraduationCap, width: 48, height: 48),
              ],
            ),
          ),
          24.verticalSpace,
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return SelectionChipButton(
                  label: languages[index].name,
                  onTap: () {
                    selectedLanguage = languages[index];
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LevelEntity {
  final String name;
  final String code;

  LevelEntity({required this.name, required this.code});
}
