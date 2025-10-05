import 'package:academeet/features/presentation/views/user_profile/user_profile_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_service.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';


class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hide the app bar height
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(AppAssets.iconBook,), // Replace with NetworkImage if needed
                  ),
                  const SizedBox(height: 10),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child){
                      final currentTheme = ref.watch(themeProvider);
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.kUserProfileEditView, arguments: UserProfileEditViewArgs(
                            currentTheme: currentTheme,
                          ));
                        },
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Veronica Rachele',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 32,color: Color(
                                0xFF333333),),
                          ],
                        ),
                      );
                    },

                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildMenuTile(
              context,
              icon: Icons.help_rounded,
              title: 'Help & Support',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildMenuTile(
              context,
              icon: Icons.credit_card,
              title: 'Payment',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildMenuTile(
              context,
              icon: Icons.info_rounded,
              title: 'About Us',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right,size: 32,color: Color(
                0xFF333333),),
          ],
        ),
      ),
    );
  }
}
