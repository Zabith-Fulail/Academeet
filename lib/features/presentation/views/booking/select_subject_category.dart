import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:academeet/features/presentation/widget/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_enum.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widget/primary_app_button.dart';

class SelectSubjectCategoryView extends StatefulWidget {
  const SelectSubjectCategoryView({super.key});

  @override
  State<SelectSubjectCategoryView> createState() =>
      _SelectSubjectCategoryViewState();
}

class _SelectSubjectCategoryViewState extends State<SelectSubjectCategoryView> {
  List<LevelOfStudy> levels = [LevelOfStudy(name: "O/L", code: "1")];
  LevelOfStudy? selectedLevel;

  List<SubjectEntity> subjects = [SubjectEntity(name: "Maths", code: "1")];
  SubjectEntity? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.verticalSpace,
                    Text(
                      'Select Subject Category',
                      style: size18weight400.copyWith(
                        color: colors(context).whiteColor,
                      ),
                    ),
                    24.verticalSpace,
                    AppDropdown<LevelOfStudy>(
                      items: levels,
                      maxDropdownHeight: 200,
                      labelText: "Study Level",
                      hintText: "Select Your Study Level",
                      itemToString: (level) => level.name,
                      selectedItem: selectedLevel,
                      onChanged: (val) {
                        selectedLevel = val;
                        setState(() {});
                      },
                    ),
                    24.verticalSpace,
                    AppDropdown<SubjectEntity>(
                      items: subjects,
                      maxDropdownHeight: 200,
                      labelText: "Subject",
                      hintText: "Select Preferred Subject Level",
                      itemToString: (subject) => subject.name,
                      selectedItem: selectedSubject,
                      onChanged: (val) {
                        selectedSubject = val;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24).w,
            child: PrimaryAppButton(
              buttonType: ButtonType.Primary,
              title: "Next",
              onTap: () {
                Navigator.pushNamed(context, Routes.kBookTutorScreen);
              },
              width: double.maxFinite,
            ),
          ),
        ],
      ),
    );
  }
}

class LevelOfStudy {
  final String name;
  final String code;

  LevelOfStudy({required this.name, required this.code});
}

class SubjectEntity {
  final String name;
  final String code;

  SubjectEntity({required this.name, required this.code});
}
