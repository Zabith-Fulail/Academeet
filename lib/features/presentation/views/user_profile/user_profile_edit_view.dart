import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../utils/app_assets.dart';
import '../../widget/app_dropdown.dart';

class UserProfileEditViewArgs {
  final AppTheme currentTheme;

  UserProfileEditViewArgs({required this.currentTheme});
}

class UserProfileEditView extends StatefulWidget {
  final UserProfileEditViewArgs userProfileEditViewArgs;

  const UserProfileEditView({super.key, required this.userProfileEditViewArgs});

  @override
  State<UserProfileEditView> createState() => _UserProfileEditViewState();
}

class _UserProfileEditViewState extends State<UserProfileEditView> {
  ThemeSelection? selectedTheme;
  List<ThemeSelection> themeSelectionList = [
    ThemeSelection(title: "mens", themeType: ThemeType.LIGHT),
    ThemeSelection(title: "ladies", themeType: ThemeType.AQUA),
    ThemeSelection(title: "unisex", themeType: ThemeType.DARK),
  ];

  @override
  void initState() {
    selectedTheme = themeSelectionList.firstWhere(
      (e) =>
          e.themeType == widget.userProfileEditViewArgs.currentTheme.themeType,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Information",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 20),

            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                      AppAssets.iconBook,
                    ), // Replace with NetworkImage if needed
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: colors(context).primaryColor500,
                    child: Icon(Icons.edit, size: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Add profile picture",
                style: TextStyle(color: Color(0xFF333333)),
              ),
            ),
            const SizedBox(height: 30),

            // Form Fields
            _buildReadOnlyField("Full name", "Veronica Rachele"),
            _buildReadOnlyField("E- mail", "vero@gmail.com"),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final currentTheme = ref.watch(themeProvider);
                return AppDropdown<ThemeSelection>(
                  onChanged: (theme) {
                    final notifier = ref.read(themeProvider.notifier);
                    // final newTheme = currentTheme.themeType == ThemeType.DARK ? ThemeType.LIGHT : ThemeType.DARK;
                    ThemeType newTheme = currentTheme.themeType;
                    if (theme.themeType == ThemeType.DARK) {
                      newTheme = ThemeType.DARK;
                    }
                    if (theme.themeType == ThemeType.LIGHT) {
                      newTheme = ThemeType.LIGHT;
                    }
                    if (theme.themeType == ThemeType.AQUA) {
                      newTheme = ThemeType.AQUA;
                    }
                    notifier.switchTheme(newTheme);
                    selectedTheme = theme;
                    setState(() {});
                  },
                  labelText: "theme selection",
                  items: themeSelectionList,
                  itemToString: (theme) => theme.title,
                  hintText: 'Select preferred theme ',
                  selectedItem: selectedTheme,
                );
              },
            ),
            SizedBox(height: 20),
            _buildReadOnlyField("Mobile", "+94 711234567"),
            _buildReadOnlyField("Birthday", "10/ 06/ 1999"),
            _buildReadOnlyField("Gender", "Female"),
            const SizedBox(height: 90),

            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Handle update
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: colors(context).buttonPrimaryColor!),
                ),
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    color: colors(context).buttonPrimaryColor!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  readOnly: false,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.edit, color: Colors.black, size: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ThemeSelection {
  String title;
  ThemeType themeType;

  ThemeSelection({required this.title, required this.themeType});
}
