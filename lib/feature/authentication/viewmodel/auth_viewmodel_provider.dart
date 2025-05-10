import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tastify_food_app/feature/authentication/repository/auth_repositories.dart';

part 'auth_viewmodel_provider.freezed.dart';
part 'auth_viewmodel_provider.g.dart';

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required bool isAuthenticated,
    required User? user,
    required bool isLoading,
    required String errorMessage,
    required bool isSuccess,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
    isAuthenticated: false,
    user: null,
    isLoading: false,
    errorMessage: '',
    isSuccess: false,
  );
}

@riverpod
class AuthViewmodelProvider extends _$AuthViewmodelProvider {
  late final AuthRepositories _authRepositories;

  @override
  AuthState build() {
    _authRepositories = ref.watch(authRepositoryProviderProvider);

    // ✅ Safe init-time listener setup
    Future.microtask(() => listenAuthState());

    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null
        ? AuthState(
          isAuthenticated: true,
          user: currentUser,
          isLoading: false,
          errorMessage: '',
          isSuccess: true,
        )
        : AuthState.initial();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: '', isSuccess: false);

    try {
      await _authRepositories.signUp(
        name: name,
        email: email,
        password: password,
      );

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        state = state.copyWith(
          user: currentUser,
          isSuccess: true,
          isAuthenticated: true,
        );

        print('sign up succefull');
      } else {
        state = state.copyWith(errorMessage: 'User not authenticated');
      }
    } catch (e) {
      print('some problem');
      state = state.copyWith(errorMessage: _handleError(e));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: '', isSuccess: false);

    try {
      await _authRepositories.signIn(email: email, password: password);

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        state = state.copyWith(
          user: currentUser,
          isSuccess: true,
          isAuthenticated: true,
        );
      } else {
        state = state.copyWith(errorMessage: 'User not authenticated');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: _handleError(e));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authRepositories.sigOut();
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: '',
        user: null,
        isAuthenticated: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        isSuccess: false,
        isLoading: false,
        user: null,
      );
    }
  }

  Future<void> listenAuthState() async {
    await _authRepositories.getAuthStateChanges().listen(
      (user) {
        if (user != null) {
          state = state.copyWith(user: user, isAuthenticated: true);
        } else {
          state = state.copyWith(isAuthenticated: false, user: null);
        }
      },
      onError: (error) {
        state = state.copyWith(errorMessage: error.toString());
      },
    );
  }

  // Firebase Exceptions
  String _handleError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'That email is already registered.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'weak-password':
          return 'Try using a stronger password.';
        case 'user-not-found':
          return 'No user found with that email.';
        case 'wrong-password':
          return 'Incorrect password.';
        default:
          return e.message ?? 'Something went wrong.';
      }
    }
    return e.toString();
  }
}
