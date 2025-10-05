import 'dart:convert';
import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  List tutors = [];
  List filteredTutors = [];
  String selectedCategory = "All";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadTutors();
  }

  Future<void> loadTutors() async {
    final String response =
    await rootBundle.loadString("assets/mock/tutors.json");
    final data = await json.decode(response);
    setState(() {
      tutors = data;
      filteredTutors = tutors;
    });
  }

  void filterTutors(String query, String category) {
    setState(() {
      searchQuery = query;
      selectedCategory = category;

      filteredTutors = tutors.where((tutor) {
        final matchesQuery =
            tutor["name"].toLowerCase().contains(query.toLowerCase()) ||
                tutor["subject"].toLowerCase().contains(query.toLowerCase());

        final matchesCategory =
            category == "All" || tutor["subject"] == category;

        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ["All", "Mathematics", "Physics", "English"];

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // 🔹 SliverAppBar without back icon
            SliverAppBar(
              automaticallyImplyLeading: false, // ✅ Removes back arrow
              backgroundColor: colors(context).buttonPrimaryColor,
              floating: true,
              snap: true,
              collapsedHeight: 60,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                title: Text(
                  "Academeet",
                  style: size22weight700.copyWith(
                    color: colors(context).buttonPrimaryColor,
                    fontSize: 26,
                  ),
                ),
                background: Container(
                  padding:
                  const EdgeInsets.only(top: 50, left: 16, right: 16),
                  alignment: Alignment.topLeft,
                  color: colors(context).surfacePrimary!.withValues(alpha: 0.9),
                ),
              ),
            ),

            // 🔹 Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search tutors or subjects",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) =>
                      filterTutors(value, selectedCategory),
                ),
              ),
            ),

            // 🔹 Categories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;

                    return ChoiceChip(
                      backgroundColor: colors(context).surfacePrimary!.withValues(alpha: 0.1),
                      selectedColor: colors(context).buttonPrimaryColor,
                      label: Text(category,
                          style: size14weight400.copyWith(
                            color: colors(context).surfacePrimary,
                          )),
                      selected: isSelected,
                      onSelected: (_) =>
                          filterTutors(searchQuery, category),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            if (searchQuery.isEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Popular Tutors",
                    style: size18weight400.copyWith(
                      color: colors(context).darkGreen,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    children: tutors
                        .where((t) => t["isPopular"] == true)
                        .map((tutor) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Open ${tutor["name"]}'s Profile"),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: colors(context).surfacePrimary!.withValues(alpha: 0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                  AssetImage(tutor["image"]),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  tutor["name"],
                                  style: size14weight700.copyWith(
                                    color: colors(context).darkGreen,
                                  ),
                                ),
                                Text(tutor["subject"],
                                    style: size12weight400.copyWith(
                                      color: colors(context)
                                          .darkGreen!
                                          .withValues(alpha: 0.7),
                                    )),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 16,
                                        color: Colors.amber),
                                    Text("${tutor["rating"]}",
                                        style: size12weight400.copyWith(
                                          color: colors(context)
                                              .whiteColor,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],

            // 🔹 All Tutors List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final tutor = filteredTutors[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    color: colors(context).surfacePrimary!.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: colors(context).darkGreen!.withValues(alpha: 0.2))
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(tutor["image"]),
                      ),
                      title: Text(tutor["name"],
                          style: size16weight400.copyWith(
                            color: colors(context).darkGreen,
                          )),
                      subtitle: Text(
                          "${tutor["subject"]} • \$${tutor["price"]}/hr",
                          style: size14weight400.copyWith(
                            color: colors(context)
                                .darkGreen!
                                .withValues(alpha: 0.7),
                          )),
                      style: ListTileStyle.drawer,
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors(context).buttonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // 🔗 Navigate to Booking
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Book ${tutor["name"]}",
                                )),
                          );
                        },
                        child: Text("Book", style: size16weight400.copyWith(color: colors(context).surfacePrimary),),
                      ),
                    ),
                  );
                },
                childCount: filteredTutors.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
