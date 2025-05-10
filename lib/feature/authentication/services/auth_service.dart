import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tastify_food_app/core/models/firebaseauth_provider.dart';

part 'auth_service.g.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  //sign Up
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (_) {
      rethrow;
    }
  }

  // Sign In

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  Stream<User?> getAuthStateChanges() => _firebaseAuth.authStateChanges();
  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

@riverpod
AuthService authServiceProvider(Ref ref) {
  return AuthService(ref.watch(firbaseAuthProvider));
}
