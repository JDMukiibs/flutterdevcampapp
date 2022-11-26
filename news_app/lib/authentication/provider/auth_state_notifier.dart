import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/authentication/authentication.dart';
import 'package:news_app/storage/storage.dart';

final authStateProvider = StateNotifierProvider.autoDispose<AuthStateNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final userInfoStorage = ref.watch(userInfoStorageProvider);

  return AuthStateNotifier(
    authService: authService,
    userInfoStorage: userInfoStorage,
  );
});

final isLoadingProvider = Provider.autoDispose<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});

final isLoggedInProvider = Provider.autoDispose<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});

final userProvider = Provider.autoDispose<User?>(
  (ref) => ref.watch(authStateProvider).user,
);

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthService authService;
  final UserInfoStorage userInfoStorage;

  AuthStateNotifier({
    required this.authService,
    required this.userInfoStorage,
  }) : super(const AuthState.unknown()) {
    if (authService.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        user: authService.currentUser,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await authService.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await authService.loginWithGoogle();
    final user = authService.currentUser;
    if (result == AuthResult.success && user != null) {
      await saveUserInfo(
        user: user,
      );
      state = AuthState(
        result: result,
        isLoading: false,
        user: user,
      );
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> saveUserInfo({required User user}) async => await userInfoStorage.saveUserInfo(
        user: user,
      );
}
