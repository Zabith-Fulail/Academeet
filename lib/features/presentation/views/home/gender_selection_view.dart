import 'package:academeet/features/presentation/views/home/widget/gender_selection_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';
import '../../cubits/promotions_cubit/promotions_cubit.dart';

class GenderSelectionView extends StatefulWidget {
  const GenderSelectionView({super.key});

  @override
  State<GenderSelectionView> createState() => _GenderSelectionViewState();
}

class _GenderSelectionViewState extends State<GenderSelectionView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PromotionsCubit>()..fetchPromotions(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const Text(
                    "Hi, ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Veronica",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colors(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final currentTheme = ref.watch(themeProvider);
                  final notifier = ref.read(themeProvider.notifier);
                  ThemeType newTheme = currentTheme.themeType;

                  return Row(
                    children: [
                      GenderSelectionComponent(
                        isFirstItem: true,
                        onTap: () {
                          newTheme = ThemeType.AQUA;
                          notifier.switchTheme(newTheme);
                          setState(() {});
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.kHomeDashboard,
                                (route) => false,
                          );
                        },
                        color: const Color(0xFFCF0868),
                        title: "Lady's Salon",
                        icon: Icons.female_rounded,
                      ),
                      GenderSelectionComponent(
                        onTap: () {
                          newTheme = ThemeType.DARK;
                          notifier.switchTheme(newTheme);
                          setState(() {});
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.kHomeDashboard,
                                (route) => false,
                          );
                        },
                        color: const Color(0xFF1B0595),
                        title: "Gent's Salon",
                        icon: Icons.male_rounded,
                      ),
                      GenderSelectionComponent(
                        onTap: () {
                          newTheme = ThemeType.LIGHT;
                          notifier.switchTheme(newTheme);
                          setState(() {});
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.kHomeDashboard,
                                (route) => false,
                          );
                        },
                        color: const Color(0xFF029386),
                        title: "Unisex Salon",
                        iconImage: AppAssets.iconUnisex,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Promotions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: BlocBuilder<PromotionsCubit, PromotionsState>(
                builder: (context, state) {
                  if (state is PromotionsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PromotionsLoaded) {
                    if (state.promotions.isEmpty) {
                      return const Center(child: Text("No promotions available"));
                    }
                    return ListView.builder(
                      itemCount: state.promotions.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final promo = state.promotions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                // Promotion image
                                promo.imageUrl != null
                                    ? Image.network(
                                  promo.imageUrl!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Image.asset(AppAssets.splashIcon,
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover),
                                )
                                    : Image.asset(AppAssets.splashIcon,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover),

                                // Overlay texts
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
                    );
                  } else if (state is PromotionsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
