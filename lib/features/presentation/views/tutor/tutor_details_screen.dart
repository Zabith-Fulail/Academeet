// NOTE: Assuming these imports are available and correctly defined
import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:academeet/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../booking/book_tutor_screen.dart';

// Reusing constants and the Tutor model definition
const Color _accentColor = Color(0xFFC7FF85);
const Color _cardColor = Color(0xFF2A2935);

// Mock Tutor Data for the example (you will pass this from the previous screen)
final Tutor mockTutor = Tutor(
  id: 101,
  name: "Dr. Alex Johnson",
  subjects: "Physics, Calculus, Advanced Algebra",
  rating: 4.9,
  totalSessions: 1200,
  imagePath: "assets/dark/png/tutor_male.png",
  pricePerHour: 35,
  isTopRated: true,
);

class TutorDetailScreen extends StatelessWidget {
  final Tutor tutor;

  const TutorDetailScreen({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surfacePrimary,

      // Use Stack to place the fixed button over the CustomScrollView
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),

              // Tutor Bio and Stats Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildTutorStats(context),
                      SizedBox(height: 24.h),
                      _buildAboutSection(context),
                      SizedBox(height: 24.h),
                      _buildSubjectsSection(context),
                      SizedBox(height: 24.h),
                      _buildReviewsHeader(context),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              // Reviews List (Sliver)
              _buildReviewsList(),

              // Padding to ensure the last review is not hidden by the sticky button
              SliverToBoxAdapter(child: SizedBox(height: 120.h)),
            ],
          ),

          // 3. STICKY BOTTOM ACTION BAR (Positioned)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStickyBookingBar(context),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildSliverAppBar(BuildContext context) {
    // Height calculation: Height of the image area + space for name/details
    final double expandedHeight = 350.h;

    return SliverAppBar(
      backgroundColor: colors(context).surfacePrimary,
      expandedHeight: expandedHeight,
      pinned: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: colors(context).whiteColor),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: colors(context).whiteColor),
          onPressed: () {
            /* Share logic */
          },
        ),
      ],

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.zero,
        title: Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
          child: Text(
            tutor.name,
            style: size22weight700.copyWith(
              color: colors(context).whiteColor,
              fontSize: 20.sp,
            ),
          ),
        ),

        background: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // Background Image Area
            Container(
              height: expandedHeight * 0.75, // Image covers top 75%
              width: double.infinity,
              color: _cardColor, // Placeholder color
              child:
                  tutor.imagePath.isNotEmpty
                      ? Image.asset(
                        tutor.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (c, e, s) => const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 100,
                            ),
                      )
                      : const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 100,
                        ),
                      ),
            ),

            // --- Creative Element: Floating Rating Badge ---
            Positioned(
              top: 200.h,
              right: 24.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: _accentColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: colors(context).surfacePrimary,
                          size: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          tutor.rating.toStringAsFixed(1),
                          style: size18weight700.copyWith(
                            color: colors(context).surfacePrimary,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${tutor.totalSessions} Sessions",
                      style: size12weight400.copyWith(
                        color: colors(context).surfacePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ------------------------------------------------
          ],
        ),
      ),
    );
  }

  Widget _buildTutorStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price per hour
        _buildStatItem(context, "\$${tutor.pricePerHour}", "Per Hour", true),
        // Divider
        Container(
          width: 1.w,
          height: 40.h,
          color: colors(context).whiteColor!.withValues(alpha: 0.2),
        ),
        // Subjects count
        _buildStatItem(
          context,
          tutor.subjects.split(',').length.toString(),
          "Subjects",
          false,
        ),
        // Divider
        Container(
          width: 1.w,
          height: 40.h,
          color: colors(context).whiteColor!.withValues(alpha: 0.2),
        ),
        // Top Rated Badge
        _buildStatItem(
          context,
          tutor.isTopRated ? "TOP" : "GOOD",
          "Status",
          false,
          color: tutor.isTopRated ? _accentColor : Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    bool isPrimary, {
    Color? color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: size18weight700.copyWith(
            color:
                color ??
                (isPrimary ? _accentColor : colors(context).whiteColor),
          ),
        ),
        Text(
          label,
          style: size14weight400.copyWith(
            color: colors(context).whiteColor!.withValues(alpha: 0.6),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Dr. Johnson",
            style: size20weight700.copyWith(color: colors(context).whiteColor),
          ),
          SizedBox(height: 8.h),
          Text(
            "Dr. Alex Johnson is a highly experienced physics tutor with a background in aerospace engineering. He specializes in making complex topics like quantum physics and calculus accessible and engaging. He has helped over 100 students achieve top grades in their university entrance exams.",
            style: size14weight400.copyWith(
              color: colors(context).whiteColor!.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsSection(BuildContext context) {
    final List<String> subjectsList =
        tutor.subjects.split(',').map((s) => s.trim()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expertise",
          style: size20weight700.copyWith(color: colors(context).whiteColor),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              subjectsList
                  .map(
                    (subject) => Chip(
                      label: Text(
                        subject,
                        style: size14weight700.copyWith(
                          color: colors(context).surfacePrimary,
                        ),
                      ),
                      backgroundColor: _accentColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildReviewsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Student Reviews (120)",
          style: size20weight700.copyWith(color: colors(context).whiteColor),
        ),
        Text("View All", style: size14weight700.copyWith(color: _accentColor)),
      ],
    );
  }

  Widget _buildReviewCard(
    BuildContext context,
    String name,
    String review,
    double rating,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: size16weight700.copyWith(
                  color: colors(context).whiteColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.w),
                  SizedBox(width: 4.w),
                  Text(
                    rating.toStringAsFixed(1),
                    style: size14weight700.copyWith(
                      color: colors(context).whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            review,
            style: size14weight400.copyWith(
              color: colors(context).whiteColor!.withValues(alpha: 0.8),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    // Mock reviews
    final mockReviews = [
      {
        'name': 'Naurez A.',
        'review':
            'Fantastic tutor! Dr. Johnson made complex physics concepts seem simple. Highly recommend for any student struggling with Calculus.',
        'rating': 5.0,
      },
      {
        'name': 'Ben C.',
        'review':
            'Great session structure and very knowledgeable. Helped me pass my final exam with flying colors!',
        'rating': 4.8,
      },
      {
        'name': 'Sarah K.',
        'review':
            'Very patient and uses excellent real-world examples. Worth every penny.',
        'rating': 4.9,
      },
    ];

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final review = mockReviews[index];
          return _buildReviewCard(
            context,
            review['name'] as String,
            review['review'] as String,
            review['rating'] as double,
          );
        }, childCount: mockReviews.length),
      ),
    );
  }

  Widget _buildStickyBookingBar(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: colors(context).surfacePrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h + bottomPadding),
      child: Row(
        children: [
          // Display Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$${tutor.pricePerHour}",
                style: size24weight700.copyWith(color: _accentColor),
              ),
              Text(
                "/ Hour",
                style: size14weight400.copyWith(
                  color: colors(context).whiteColor!.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          SizedBox(width: 24.w),
          // Book Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Navigate to final scheduling/payment screen
                // Navigator.pushNamed(context, Routes.kSelectSubjectCategory);

                Navigator.pushNamed(context, Routes.kBookTutorScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: Text(
                "Book Session Now",
                style: size18weight700.copyWith(
                  color: colors(context).surfacePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
