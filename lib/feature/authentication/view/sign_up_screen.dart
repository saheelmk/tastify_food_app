import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tastify_food_app/core/constants/app_tex.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';
import 'package:tastify_food_app/feature/authentication/viewmodel/auth_viewmodel_provider.dart';
import 'package:tastify_food_app/feature/authentication/widgets/input_field.dart';
import 'package:tastify_food_app/feature/authentication/widgets/social_icon.dart';
import 'package:tastify_food_app/main.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});
  static final String router = '/signup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameText = useTextEditingController();
    final emailText = useTextEditingController();
    final passwordText = useTextEditingController();
    final confirmPasswordText = useTextEditingController();
    final isLoading = ref.watch(authViewmodelProviderProvider).isLoading;

    // ✅ Move the listener into useEffect
    useEffect(() {
      ref.listen<AuthState>(authViewmodelProviderProvider, (previous, next) {
        if (next.isAuthenticated) {
          Navigator.pushReplacementNamed(context, HomeScreen.router);
        }

        if (next.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.errorMessage)));
        }
      });

      // 👇 No cleanup needed, so don't return anything
      return null;
    }, []);

    void showSnack(String message) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    bool isValidEmail(String email) {
      return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(email);
    }

    bool isValidPassword(String password) {
      return RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
      ).hasMatch(password);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppText.headingLarge(
                      context,
                      "T",
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Create your account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              InputField(
                label: "Name",
                hint: "ex: saheel",
                controller: nameText,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Email',
                hint: 'ex: saheelmk@gmail.com',
                controller: emailText,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Password',
                hint: '',
                controller: passwordText,
                obscure: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Confirm password',
                hint: '',
                controller: confirmPasswordText,
                obscure: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  text: 'I understood the ',
                  children: [
                    TextSpan(
                      text: 'terms & policy.',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            final name = nameText.text.trim();
                            final email = emailText.text.trim();
                            final password = passwordText.text.trim();
                            final confirm = confirmPasswordText.text.trim();

                            if (name.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty ||
                                confirm.isEmpty) {
                              showSnack("Please fill all fields.");
                              return;
                            }

                            if (!isValidEmail(email)) {
                              showSnack("Invalid email format.");
                              return;
                            }

                            if (!isValidPassword(password)) {
                              showSnack(
                                "Password must include A-Z, a-z, 0-9 & special char (min 8 chars).",
                              );
                              return;
                            }

                            if (password != confirm) {
                              showSnack("Passwords don't match.");
                              return;
                            }

                            ref
                                .read(authViewmodelProviderProvider.notifier)
                                .signUp(
                                  name: name,
                                  email: email,
                                  password: password,
                                );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      isLoading
                          ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                          : const Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  'or sign up with',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SocialIcon(icon: FontAwesomeIcons.google),
                  SocialIcon(icon: FontAwesomeIcons.facebookF),
                  SocialIcon(icon: FontAwesomeIcons.twitter),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
