import 'dart:convert';
import 'package:academeet/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';


const Color _accentColor = Color(0xFFC7FF85);
const Color _cardColor = Color(0xFF2A2935);

// -------------------------------------------------------------------
// 1. TUTOR MODEL & SERVICE (Unchanged)
// -------------------------------------------------------------------

class Tutor {
  final int id;
  final String name;
  final String subjects;
  final double rating;
  final int totalSessions;
  final String imagePath;
  final int pricePerHour;
  final bool isTopRated;

  Tutor({
    required this.id,
    required this.name,
    required this.subjects,
    required this.rating,
    required this.totalSessions,
    required this.imagePath,
    required this.pricePerHour,
    required this.isTopRated,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'] as int,
      name: json['name'] as String,
      subjects: json['subjects'] as String,
      rating: (json['rating'] as num).toDouble(),
      totalSessions: json['total_sessions'] as int,
      imagePath: json['image_path'] as String,
      pricePerHour: json['price_per_hour'] as int,
      isTopRated: json['is_top_rated'] as bool,
    );
  }
}

class TutorService {
  static const String _tutorsJsonPath = 'assets/mock/tutors.json';

  static Future<List<Tutor>> loadTutors() async {
    try {
      final String response = await rootBundle.loadString(_tutorsJsonPath);
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Tutor.fromJson(json)).toList();
    } catch (e) {
      // print("Error loading tutors: $e");
      return [];
    }
  }
}


class BookTutorScreen extends StatefulWidget {
  const BookTutorScreen({super.key});

  @override
  State<BookTutorScreen> createState() => _BookTutorScreenState();
}

class _BookTutorScreenState extends State<BookTutorScreen> {
  late Future<List<Tutor>> _tutorsFuture;
  List<Tutor> _allTutors = [];
  List<Tutor> _filteredTutors = [];
  String _selectedSubject = "All";
  final TextEditingController _searchController = TextEditingController();
  final List<String> _subjects = ["All", "Math", "Science", "Languages", "Art", "History", "CS"];

  @override
  void initState() {
    super.initState();
    _tutorsFuture = TutorService.loadTutors();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _onChipSelected(String subject) {
    setState(() {
      _selectedSubject = subject;
      _applyFilters();
    });
  }

  void _applyFilters() {
    final String query = _searchController.text.toLowerCase();

    setState(() {
      _filteredTutors = _allTutors.where((tutor) {
        final bool matchesSubject = _selectedSubject == "All" ||
            tutor.subjects.toLowerCase().contains(_selectedSubject.toLowerCase());

        final bool matchesSearch = tutor.name.toLowerCase().contains(query) ||
            tutor.subjects.toLowerCase().contains(query);

        return matchesSubject && matchesSearch;
      }).toList();
    });
  }

  // --- Widget Build Overrides (Refactored to use CustomScrollView) ---

  @override
  Widget build(BuildContext context) {
    // The Scaffold body is now a CustomScrollView, which replaces the SafeArea and Column
    return Scaffold(
      backgroundColor: colors(context).surfacePrimary,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),

          // 1. Static Header Content (Search/Filter) below the App Bar
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 24.h),
                  _buildSearchBar(context),
                  SizedBox(height: 16.h),
                  _buildFilterChips(context),
                  SizedBox(height: 24.h),
                  // Text(
                  //   "Top Rated Tutors",
                  //   style: size22weight700.copyWith(
                  //     color: colors(context).whiteColor,
                  //     fontSize: 22.sp,
                  //   ),
                  // ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),

          // 2. Dynamic Tutor List
          _buildTutorList(),
        ],
      ),
    );
  }

  // --- New SliverAppBar Builder ---

  // Inside _BookTutorScreenState


  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: colors(context).surfacePrimary,
      automaticallyImplyLeading: false,
      // --- KEY CHANGES HERE ---
      pinned: false,    // Now allows the bar to completely leave the screen
      snap: true,       // Snaps open/closed smoothly
      floating: true,   // Reappears immediately on scroll up
      // ------------------------


      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
          child: Row(
            children: [
              // Back Button
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: colors(context).whiteColor, size: 24.w),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 8.w),
              // Title text
              Text(
                "Book a Tutor",
                style: size22weight700.copyWith(
                  color: colors(context).whiteColor,
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Updated Sliver List Builder ---

  Widget _buildTutorList() {
    return FutureBuilder<List<Tutor>>(
      future: _tutorsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator(color: _accentColor)),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(
              child: Text("Failed to load tutors: ${snapshot.error}",
                  style: TextStyle(color: colors(context).whiteColor)),
            ),
          );
        } else if (snapshot.hasData) {
          if (_allTutors.isEmpty) {
            _allTutors = snapshot.data!;
            _filteredTutors = _allTutors;
          }

          if (_filteredTutors.isEmpty) {
            return SliverFillRemaining(
              child: Center(
                child: Text("No tutors match your search/filter.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors(context).whiteColor!.withValues(alpha: 0.6))),
              ),
            );
          }

          // Use SliverList to display the dynamic list items
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final tutor = _filteredTutors[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildTutorCard(
                    context,
                    tutor.name,
                    tutor.subjects,
                    tutor.rating.toStringAsFixed(1),
                    tutor.totalSessions.toString(),
                    tutor.imagePath,
                  ),
                );
              },
              childCount: _filteredTutors.length,
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  // --- Other Widget Builders (Unchanged in functionality) ---

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: _searchController,
        style: size16weight400.copyWith(color: colors(context).whiteColor),
        decoration: InputDecoration(
          hintText: "Search by subject or name...",
          hintStyle: size16weight400.copyWith(color: colors(context).whiteColor!.withValues(alpha: 0.5)),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: _accentColor),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _subjects.map((subject) {
          final bool isActive = _selectedSubject == subject;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: InkWell(
              onTap: () => _onChipSelected(subject),
              child: _buildChip(context, subject, isActive),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isActive) {
    return Chip(
      label: Text(
        label,
        style: size14weight700.copyWith(
          color: isActive ? colors(context).surfacePrimary : colors(context).whiteColor,
        ),
      ),
      backgroundColor: isActive ? _accentColor : _cardColor,
      side: BorderSide.none,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }

  Widget _buildTutorCard(
      BuildContext context,
      String name,
      String subjects,
      String rating,
      String sessions,
      String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.kTutorDetailScreen, arguments: Tutor(id: 1, name: "name", subjects: "subjects", rating: 2.2, totalSessions: 1200, imagePath: "", pricePerHour: 120, isTopRated: true));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.w,
                  backgroundColor: _accentColor.withValues(alpha: 0.2),
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.person, color: _accentColor, size: 30.w),
                      fit: BoxFit.cover,
                      width: 60.w,
                      height: 60.w,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: size18weight700.copyWith(color: colors(context).whiteColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subjects,
                        style: size14weight400.copyWith(color: colors(context).whiteColor!.withValues(alpha: 0.7)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _accentColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: colors(context).surfacePrimary, size: 14.w),
                      SizedBox(width: 4.w),
                      Text(
                        rating,
                        style: size14weight700.copyWith(color: colors(context).surfacePrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: colors(context).whiteColor!.withValues(alpha: 0.1), height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sessions,
                    style: size18weight700.copyWith(color: _accentColor),
                  ),
                  Text(
                    "Sessions",
                    style: size14weight400.copyWith(color: colors(context).whiteColor!.withValues(alpha: 0.5)),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to the final booking details screen
                },
                icon: Icon(Icons.calendar_today, color: colors(context).surfacePrimary, size: 16.w),
                label: Text(
                  "Book Now",
                  style: size16weight700.copyWith(color: colors(context).surfacePrimary),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
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