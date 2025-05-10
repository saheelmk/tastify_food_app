import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tastify_food_app/core/router/app_router.dart';
import 'package:tastify_food_app/core/themes/app_theme.dart';
import 'package:tastify_food_app/feature/homescreen/view/home_page.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/custom_bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final String router = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);
    final pages = [
      const HomePage(),
      Center(child: Text("Cart")),
      Center(child: const Text('Profile')),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const CustomBottomNavBar(),
      ),
    );
  }
}
