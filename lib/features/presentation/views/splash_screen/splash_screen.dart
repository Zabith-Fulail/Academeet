
import 'package:academeet/core/theme/text_styles.dart';
import 'package:academeet/core/theme/theme_data.dart';
import 'package:academeet/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../utils/navigation_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();

    // Scale animation (zoom in/out)
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);

    // Shine animation (sliding gradient)
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    Future.delayed(Duration(seconds: 5), () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    Navigator.pushReplacementNamed(context, Routes.kSignUpView);
  }
  @override
  void dispose() {
    _scaleController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleController, _shineController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleController.value,
              child: ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment(-1.0 + _shineController.value * 2, 0),
                    end: Alignment(1.0 + _shineController.value * 2, 0),
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                    stops: const [0.2, 0.5, 0.8],
                  ).createShader(bounds);
                },
                child: Text(AppStrings.appName,style: size24weight700.copyWith(
                  color: colors(context).darkGreen
                ),),
              ),
            );
          },
        ),
      ),
    );
  }
}
