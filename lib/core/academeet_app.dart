import 'package:academeet/core/service/dependency_injection.dart';
import 'package:academeet/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/presentation/cubits/otp/otp_cubit.dart';
import '../features/presentation/cubits/promotions_cubit/promotions_cubit.dart';
import '../utils/app_assets.dart';
import '../utils/app_constants.dart';
import '../utils/navigation_routes.dart';

class AcadeMeetApp extends ConsumerStatefulWidget {
  const AcadeMeetApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AcadeMeetCustomerAppState();
}

class _AcadeMeetCustomerAppState extends ConsumerState<AcadeMeetApp> {
  final AppAssets appAssets = AppAssets();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    appAssets.setTheme(theme.themeType);
    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpCubit>(
          create: (_) => sl<OtpCubit>(),
        ),
        BlocProvider<PromotionsCubit>(
          create: (_) => sl<PromotionsCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (_, child) {
          return MaterialApp(
            theme: theme.themeData,
            title: AppConstants.appName,
            initialRoute: Routes.kSplashView,
            onGenerateRoute: Routes.generateRoute,

          );
        }
      ),
    );
  }
}
