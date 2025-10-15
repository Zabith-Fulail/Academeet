import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../widget/selection_chip_button.dart';
import 'language_selection_view.dart';
import 'level_selection_view.dart';

class SubjectSelectionViewArgs {
  final LanguageEntity selectedLanguage;
  final LevelEntity selectedLevel;

  SubjectSelectionViewArgs({
    required this.selectedLanguage,
    required this.selectedLevel,
  });
}

class SubjectSelectionView extends StatefulWidget {
  final SubjectSelectionViewArgs subjectSelectionViewArgs;

  const SubjectSelectionView({super.key, required this.subjectSelectionViewArgs});

  @override
  State<SubjectSelectionView> createState() => _SubjectSelectionViewState();
}

class _SubjectSelectionViewState extends State<SubjectSelectionView> {
  List<SubjectEntity> languages = [
    SubjectEntity(name: "Maths", code: "1"),
    SubjectEntity(name: "Science", code: "2"),
    SubjectEntity(name: "ICT", code: "3"),
    SubjectEntity(name: "History", code: "4"),
  ];
  SubjectEntity? selectedLanguage;

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
                  "Select Subject",
                  style: size20weight700.copyWith(
                    color: colors(context).whiteColor,
                  ),
                ),
                8.horizontalSpace,
                Image.asset(AppAssets.icBook, width: 48, height: 48),
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

class SubjectEntity {
  final String name;
  final String code;

  SubjectEntity({required this.name, required this.code});
}
