import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tastify_food_app/feature/authentication/services/auth_service.dart';

part 'auth_repositories.g.dart';

class AuthRepositories {
  final AuthService _authservice;
  AuthRepositories(this._authservice);

  // Firebase Auth Sign UP

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await _authservice.signUp(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Firebase Auth Sign In

  Future<void> signIn({required String email, required String password}) async {
    try {
      return await _authservice.signIn(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> getAuthStateChanges() => _authservice.getAuthStateChanges();

  // Firebase Sign out
  Future<void> sigOut() async {
    await _authservice.signOut();
  }
}

@riverpod
AuthRepositories authRepositoryProvider(Ref ref) {
  return AuthRepositories(ref.watch(authServiceProviderProvider));
}
