import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tastify_food_app/core/constants/app_tex.dart';
import 'package:tastify_food_app/feature/authentication/view/sign_in_screen.dart';
import 'package:tastify_food_app/feature/authentication/viewmodel/auth_viewmodel_provider.dart';
import 'package:tastify_food_app/main.dart';

class FoodForHumanityScreen extends HookConsumerWidget {
  const FoodForHumanityScreen({super.key});
  static final String router = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Delay the navigation after build completes
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        final authState = ref.read(authViewmodelProviderProvider);

        if (authState.isAuthenticated || authState.user != null) {
          context.go(HomeScreen.router);
        } else {
          context.go(SignInScreen.router);
        }
      });

      return null;
    }, []);

    return Scaffold(
      body: Stack(
        children: [
          // Background image with green overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/full_sized.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xCC00A651),
                  BlendMode.srcATop,
                ),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon box
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: AppText.headingLarge(context, 'T')),
                ),
                const SizedBox(height: 20),

                AppText.headingLarge(context, 'FOOD FOR\nHUMANITY'),
                const SizedBox(height: 30),

                AppText.bodyLarge(context, 'Welcome to\nTastify Food'),

                Lottie.asset(
                  'assets/animations/loading.json',
                  width: 250,
                  height: 250,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
