import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/authentication/authentication.dart';
import 'package:news_app/storage/storage.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserInfoStorage extends Mock implements UserInfoStorage {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements UserCredential {}