import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/authentication/authentication.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockUserInfoStorage mockUserInfoStorage;
  late MockUser mockUser;

  group('AuthStateNotifier', () {
    setUpAll(() {
      mockAuthService = MockAuthService();
      mockUserInfoStorage = MockUserInfoStorage();
      mockUser = MockUser();
    });

    group('signIn', () {
      test('Successful sign in updates state with User and AuthResult.success', () async {
        when(() => mockAuthService.isAlreadyLoggedIn).thenAnswer((_) => false);
        when(() => mockAuthService.loginWithGoogle()).thenAnswer(
          (_) async => AuthResult.success,
        );
        when(() => mockAuthService.currentUser).thenAnswer((_) => mockUser);
        when(
          () => mockUserInfoStorage.saveUserInfo(user: mockUser),
        ).thenAnswer((_) async => true);

        final authStateNotifier = AuthStateNotifier(
          authService: mockAuthService,
          userInfoStorage: mockUserInfoStorage,
        );

        await authStateNotifier.loginWithGoogle();

        verify(() => mockAuthService.isAlreadyLoggedIn).called(1);
        verify(() => mockAuthService.loginWithGoogle()).called(1);
        verify(() => mockAuthService.currentUser).called(1);
        verify(
          () => mockUserInfoStorage.saveUserInfo(user: mockUser),
        ).called(1);
        expect(
          authStateNotifier.debugState,
          AuthState(
            result: AuthResult.success,
            isLoading: false,
            user: mockUser,
          ),
        );
      });

      test('Failure to sign in should maintain state as AuthState.unknown', () async {
        when(() => mockAuthService.isAlreadyLoggedIn).thenAnswer((_) => false);
        when(() => mockAuthService.loginWithGoogle()).thenAnswer(
          (_) async => AuthResult.failure,
        );
        when(() => mockAuthService.currentUser).thenAnswer((_) => null);

        final authStateNotifier = AuthStateNotifier(
          authService: mockAuthService,
          userInfoStorage: mockUserInfoStorage,
        );

        await authStateNotifier.loginWithGoogle();

        verify(() => mockAuthService.isAlreadyLoggedIn).called(1);
        verify(() => mockAuthService.loginWithGoogle()).called(1);
        verify(() => mockAuthService.currentUser).called(1);
        expect(
          authStateNotifier.debugState,
          const AuthState.unknown(),
        );
      });
    });

    group('logOut', () {
      test('Successful logout should reset state to AuthState.unknown', () async {
        when(() => mockAuthService.isAlreadyLoggedIn).thenAnswer((_) => true);
        when(() => mockAuthService.currentUser).thenAnswer((_) => mockUser);
        final authStateNotifier = AuthStateNotifier(
          authService: mockAuthService,
          userInfoStorage: mockUserInfoStorage,
        );
        expect(
          authStateNotifier.debugState,
          AuthState(
            result: AuthResult.success,
            isLoading: false,
            user: mockUser,
          ),
        );

        when(() => mockAuthService.logOut()).thenAnswer((_) async => {});

        await authStateNotifier.logOut();

        verify(() => mockAuthService.isAlreadyLoggedIn).called(1);
        verify(() => mockAuthService.currentUser).called(1);
        verify(() => mockAuthService.logOut()).called(1);
        expect(
          authStateNotifier.debugState,
          const AuthState.unknown(),
        );
      });
    });
  });
}
