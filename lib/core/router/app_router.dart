import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tastify_food_app/feature/authentication/view/splash_screen.dart';
import 'package:tastify_food_app/feature/authentication/view/sign_in_screen.dart';
import 'package:tastify_food_app/feature/authentication/view/sign_up_screen.dart';
import 'package:tastify_food_app/main.dart';

part 'app_router.g.dart';

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: FoodForHumanityScreen.router,
      routes: [
        GoRoute(
          path: HomeScreen.router,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: FoodForHumanityScreen.router,
          builder: (context, state) => FoodForHumanityScreen(),
        ),
        GoRoute(
          path: SignInScreen.router,
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: SignUpScreen.router,
          builder: (context, state) => SignUpScreen(),
        ),
      ],
    );
  }
}
