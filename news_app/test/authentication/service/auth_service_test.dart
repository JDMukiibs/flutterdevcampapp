import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/authentication/authentication.dart';

import '../../mocks/mocks.dart';

void main() {
  late final MockFirebaseAuth mockFirebaseAuth;
  late final MockGoogleSignIn mockGoogleSignIn;
  late final MockGoogleSignInAccount mockGoogleSignInAccount;
  late final MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  late final MockUserCredential mockUserCredential;
  late final OAuthCredential mockCredentials;
  late final AuthService authService;
  const mockAccessToken = 'mockAccessToken';
  const mockIdToken = 'mockIdToken';

  group('AuthService Tests', () {
    setUpAll(() {
      mockGoogleSignIn = MockGoogleSignIn();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      mockCredentials = GoogleAuthProvider.credential(
        accessToken: mockAccessToken,
        idToken: mockIdToken,
      );
      authService = AuthService(
        firebaseAuthOverride: mockFirebaseAuth,
        googleSignInOverride: mockGoogleSignIn,
        credentialsOverride: mockCredentials,
      );
    });

    test('loginWithGoogle returns AuthResult.aborted', () async {
      when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      final actualAuthResult = await authService.loginWithGoogle();

      expect(actualAuthResult, AuthResult.aborted);
      verify(() => mockGoogleSignIn.signIn()).called(1);
    });

    test('loginWithGoogle returns AuthResult.success', () async {
      when(() => mockGoogleSignIn.signIn()).thenAnswer(
        (_) async => mockGoogleSignInAccount,
      );
      when(() => mockGoogleSignInAccount.authentication).thenAnswer(
        (_) async => mockGoogleSignInAuthentication,
      );
      when(() => mockFirebaseAuth.signInWithCredential(mockCredentials)).thenAnswer((_) async => mockUserCredential);

      final actualAuthResult = await authService.loginWithGoogle();

      expect(actualAuthResult, AuthResult.success);
      verify(() => mockGoogleSignIn.signIn()).called(1);
      verify(() => mockGoogleSignInAccount.authentication).called(1);
      verify(() => mockFirebaseAuth.signInWithCredential(mockCredentials)).called(1);
    });

    test('loginWithGoogle returns AuthResult.failure', () async {
      when(
        () => mockGoogleSignIn.signIn(),
      ).thenAnswer(
        (_) async => mockGoogleSignInAccount,
      );
      when(
        () => mockGoogleSignInAccount.authentication,
      ).thenAnswer(
        (_) async => mockGoogleSignInAuthentication,
      );
      when(
        () => mockFirebaseAuth.signInWithCredential(mockCredentials),
      ).thenThrow(
        Exception('oops'),
      );

      final actualAuthResult = await authService.loginWithGoogle();

      expect(actualAuthResult, AuthResult.failure);
      verify(() => mockGoogleSignIn.signIn()).called(1);
      verify(() => mockGoogleSignInAccount.authentication).called(1);
      verify(() => mockFirebaseAuth.signInWithCredential(mockCredentials)).called(1);
    });
  });
}
