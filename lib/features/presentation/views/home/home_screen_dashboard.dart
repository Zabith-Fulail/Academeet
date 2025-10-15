import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:academeet/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_constants.dart';

// --- Placeholder Classes for AppConstants and TextStyles ---
// NOTE: I'm defining minimal versions here to make the example runnable.
// You should ensure these align with your actual files.
// Assume AppConstants.user.username = 'Naurez'
class _User {
  final String username;

  const _User(this.username);
}
// -----------------------------------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // We'll use a standard Scaffold body with a SingleChildScrollView
    // for a simpler layout that matches the non-collapsible header in the image.
    return Scaffold(
      // The background color for the entire screen
      backgroundColor: colors(context).surfacePrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. DASHBOARD HEADER & MENU ICON
              SizedBox(height: 36.h),
              _buildHeader(context),

              // 2. READY TO LEARN SECTION
              SizedBox(height: 24.h),
              _buildReadyToLearnCard(context),

              // 3. UPCOMING SCHEDULES SECTION
              SizedBox(height: 16.h),
              _buildSchedulesRow(context),

              // 4. ANALYTICS SECTION
              SizedBox(height: 32.h),
              _buildAnalyticsSection(context),

              // Add some padding at the bottom for the fixed navigation bar
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
      // 5. BOTTOM NAVIGATION BAR (Placeholder)
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: size22weight700.copyWith(
                color: colors(context).buttonPrimaryColor,
                fontSize: 26.sp, // Match the large size from the image
              ),
            ),
            Row(
              children: [
                Text(
                  "Welcome Back, ${AppConstants.user.username}",
                  style: size16weight700.copyWith(
                    color: colors(
                      context,
                    ).whiteColor!.withValues(alpha: 0.7), // Slightly dimmed
                  ),
                ),
                SizedBox(width: 6.w),
                Text("👋", style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ],
        ),
        // Menu Icon (Hamburger)
        Icon(Icons.menu, color: colors(context).whiteColor, size: 28.w),
      ],
    );
  }

  Widget _buildReadyToLearnCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(top: 22.h),
          height: 140.h,
          decoration: BoxDecoration(
            color: Color(0xFF2A2935), // Dark gray card background
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text and Button Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ready to learn ?",
                    style: size22weight700.copyWith(
                      color: colors(context).whiteColor,
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Let's book a tutor!",
                    style: size16weight700.copyWith(
                      color: colors(context).whiteColor!.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.kSelectSubjectCategory);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC7FF85),
                      // The light green color
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      "BOOK NOW",
                      style: size16weight700.copyWith(
                        color: colors(context).surfacePrimary, // Dark text
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              // Placeholder for the 3D character image
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Image .asset("assets/dark/png/studyingImg.png", height: 150.h)),
              )
            ],
          ),
        )

      ],
    );
  }

  Widget _buildSchedulesRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 130.h,
            decoration: BoxDecoration(
              color: const Color(0xFFC7FF85), // Solid light green
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF9DDB81).withValues(alpha: 0.5),
                    // Light green background
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  width: 130.w,
                  height: 130.h,
                  child: Stack(
                    children: [
                      // Placeholder for Alarm Clock image
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/dark/png/alarmClock.png",
                          height: 150.h,
                          width: 150.w,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 12, 12, 0).w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "03",
                            style: size14weight700.copyWith(
                              color: colors(context).whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                50.horizontalSpace,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming\nSchedules",
                        style: size24weight700.copyWith(
                          color: colors(context).surfacePrimary,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors(context).surfacePrimary,
                          // Dark button background
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "VIEW ALL",
                          style: size14weight700.copyWith(
                            color: const Color(0xFFC7FF85),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Analytics",
          style: size22weight700.copyWith(
            color: colors(context).whiteColor,
            fontSize: 26.sp,
          ),
        ),
        SizedBox(height: 16.h),
        _buildAnalyticItem(context, 'Total Study Hours', '178 Hours'),
        _buildAnalyticItem(context, 'Total Sessions', '39 Sessions'),
        _buildAnalyticItem(context, 'Tutors Connected', '5 Tutors'),
      ],
    );
  }

  Widget _buildAnalyticItem(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color(0xFF2A2935),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // White Dot Icon
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: colors(context).whiteColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),
            // Title and Value
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: size16weight700.copyWith(
                    color: colors(context).whiteColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  value,
                  style: size14weight400.copyWith(
                    color: colors(context).darkGreen!.withValues(alpha: 0.6),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 60.h,
      // Keep the margin for safe area and for a floating margin effect
      margin: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 1. ACTIVE ICON: Elevated Circle with Inner Shadow
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: const Color(0xFFC7FF85),
              shape: BoxShape.circle,
              boxShadow: [
                // Dark shadow (giving the "pressed" or "carved out" effect from the background)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.7),
                  offset: const Offset(3, 3),
                  blurRadius: 5,
                ),
                // Light shadow (giving the "lifted" effect)
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.1),
                  offset: const Offset(-3, -3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.home,
              color: colors(context).secondaryColor, // Dark icon color
              size: 24.w,
            ),
          ),

          // 2. Placeholder Icons (Inactive)
          _buildInactiveIcon(context, Icons.bookmark_border),
          _buildInactiveIcon(context, Icons.search),
          _buildInactiveIcon(context, Icons.chat_bubble_outline),
          _buildInactiveIcon(context, Icons.person_outline),
        ],
      ),
    );
  }
// Note: Use the same _buildInactiveIcon helper function from Option 1
  Widget _buildInactiveIcon(BuildContext context, IconData icon) {
    return Icon(
      icon,
      color: colors(context).whiteColor!.withValues(alpha: 0.4), // Use withOpacity for simplicity
      size: 24.w,
    );
  }
}
