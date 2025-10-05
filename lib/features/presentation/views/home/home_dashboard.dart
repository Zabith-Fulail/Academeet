import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';
import '../../cubits/promotions_cubit/promotions_cubit.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _UpdatedDashboardViewState();
}

class _UpdatedDashboardViewState extends State<HomeDashboard> {
  bool showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearchBar() {
    setState(() {
      showSearchBar = !showSearchBar;
      if (!showSearchBar) _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch promotions when dashboard loads
    context.read<PromotionsCubit>().fetchPromotions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 🔹 Top AppBar
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              expandedHeight: 120,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Row(
                    children: [
                      const Text("Hi, ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400)),
                      Text(
                        "Veronica",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colors(context).primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: colors(context).primaryColor500,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(
                            showSearchBar ? Icons.close : Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: _toggleSearchBar,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: colors(context).primaryColor500,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_none,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.kNotificationView);
                              },
                            ),
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  "9",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🔹 Search Bar
            if (showSearchBar)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search salon or service...",
                      filled: true,
                      fillColor: colors(context).primaryColor500,
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

            // 🔹 Location Row
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: colors(context).primaryColor500,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child:
                        const Icon(Icons.location_on, color: Colors.white)),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Change",
                          style: TextStyle(
                            color: colors(context).primaryColor,
                          )),
                    )
                  ],
                ),
              ),
            ),

            // 🔹 Promo Banner (from API)
            SliverToBoxAdapter(
              child: BlocBuilder<PromotionsCubit, PromotionsState>(
                builder: (context, state) {
                  if (state is PromotionsLoading) {
                    return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ));
                  } else if (state is PromotionsError) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                    );
                  } else if (state is PromotionsLoaded) {
                    return CarouselSlider.builder(
                      itemCount: state.promotions.length,
                      itemBuilder: (context, index, realIndex) {
                        final promo = state.promotions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Image.network(
                                  promo.imageUrl ?? AppAssets.splashIcon,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        promo.promotionName ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        promo.description ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        padEnds: false,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            // 🔹 Latest Visit
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: const Text("LATEST VISIT",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 72,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  children: [
                    _latestVisitCard("Salon Susee", "4.8"),
                    _latestVisitCard("Beauty Bliss", "4.7"),
                    _latestVisitCard("Nail Paradise", "4.6"),
                  ],
                ),
              ),
            ),

            // 🔹 Lady's Saloons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: const Text("Lady’s Saloons",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _salonCard(
                  name: "Blush Heaven",
                  rating: "4.8",
                  description: "Best in class saloon for women in Colombo.",
                  imageUrl: AppAssets.splashIcon,
                ),
              ]),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  // 🔹 Latest Visit Card
  Widget _latestVisitCard(String name, String rating) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              AppAssets.splashIcon,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: size18weight400.copyWith(
                        color: colors(context).whiteColor)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(rating,
                        style: size12weight400.copyWith(
                            color: colors(context).whiteColor)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 🔹 Salon Card
  Widget _salonCard({
    required String name,
    required String rating,
    required String description,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.kAcademeetView);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(rating),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
