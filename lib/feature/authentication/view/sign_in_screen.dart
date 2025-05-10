import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tastify_food_app/core/constants/app_spacing.dart';
import 'package:tastify_food_app/core/constants/app_tex.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';
import 'package:tastify_food_app/feature/authentication/view/sign_up_screen.dart';
import 'package:tastify_food_app/feature/authentication/viewmodel/auth_viewmodel_provider.dart';
import 'package:tastify_food_app/feature/authentication/widgets/social_icon.dart';
import 'package:tastify_food_app/main.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});
  static final String router = '/signin';

  // Toggle password visibility
  void _toggleVisibility(ValueNotifier<bool> obscureTextNotifier) {
    obscureTextNotifier.value = !obscureTextNotifier.value;
  }

  // Build loading indicator widget
  Widget _buildLoadingIndicator(bool isLoading) {
    return isLoading
        ? CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        )
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscureText = useState(true);

    // Sign In Logic
    Future<void> _signIn() async {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please fill in both fields.')));
        return;
      }

      // Basic email validation
      final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
      final regex = RegExp(emailPattern);

      if (!regex.hasMatch(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid email address.')),
        );
        return;
      }

      try {
        await ref
            .read(authViewmodelProviderProvider.notifier)
            .signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
      } catch (e) {
        String errorMessage = 'Sign-in failed';
        if (e is FirebaseAuthException) {
          errorMessage = 'Invalid credentials. Please try again.';
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }

    ref.listen<AuthState>(authViewmodelProviderProvider, (prev, next) {
      if (next.isAuthenticated) {
        Navigator.pushReplacementNamed(context, HomeScreen.router);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),

            // T Logo in rounded box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: AppText.headingLarge(
                context,
                'T',
                color: AppColors.primary,
              ),
            ),
            AppSpacing.verticalLarge,
            // Heading
            AppText.heading(context, 'Sign in your account'),

            AppSpacing.verticalLarge,

            // Email Field
            TextFormField(
              style: TextStyle(color: AppColors.black),
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'ex: jon.smith@email.com',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            AppSpacing.verticalMedium,

            // Password Field
            TextFormField(
              style: TextStyle(color: AppColors.black),
              controller: passwordController,
              obscureText: obscureText.value,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText.value ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => _toggleVisibility(obscureText),
                ),
              ),
            ),

            AppSpacing.verticalLarge,

            // Sign In Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _signIn,
                    child: AppText.headingSmall(
                      context,
                      'SIGN IN',
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: _buildLoadingIndicator(
                      ref.watch(authViewmodelProviderProvider).isLoading,
                    ),
                  ),
                ],
              ),
            ),

            AppSpacing.verticalLarge,

            AppText.captionLarge('or sign in with'),
            AppSpacing.verticalMedium,

            // Social buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialIcon(icon: FontAwesomeIcons.google),
                SocialIcon(icon: FontAwesomeIcons.facebookF),
                SocialIcon(icon: FontAwesomeIcons.twitter),
              ],
            ),
            AppSpacing.verticalLarge,

            // Bottom link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.body(context, 'Don’t have an account? '),
                TextButton(
                  onPressed: () {
                    context.push(SignUpScreen.router);
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
