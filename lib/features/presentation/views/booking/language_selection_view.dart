import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:academeet/utils/app_assets.dart';
import 'package:academeet/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/selection_chip_button.dart';

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  List<LanguageEntity> languages = [LanguageEntity(name: "English", code: "1"),LanguageEntity(name: "Sinhala", code: "2"),LanguageEntity(name: "Tamil", code: "3")];
  LanguageEntity? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          60.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).w,
            child: Text("Find Tutor",style: size20weight700.copyWith(color: colors(context).darkGreen),),
          ),
          8.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).w,
            child: Row(
              children: [
                Text("Select Language",style: size20weight700.copyWith(color: colors(context).whiteColor),),
                8.horizontalSpace,
                Image.asset(AppAssets.icGlobe,width: 48,height: 48,),
              ],
            ),
          ),
          24.verticalSpace,
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: languages.length,
                itemBuilder: (context, index){
              return SelectionChipButton(
                label: languages[index].name,
                onTap: (){
                  selectedLanguage = languages[index];
                  setState(() {});
                  Navigator.pushNamed(context, Routes.kLevelSelectionView,arguments: selectedLanguage);
                },
              );
            }),
          ),
        ],
      )
    );
  }
}
class LanguageEntity {
  final String name;
  final String code;

  LanguageEntity({required this.name, required this.code});
}