import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/authentication/authentication.dart';

class AuthService {
  AuthService({
    FirebaseAuth? firebaseAuthOverride,
    GoogleSignIn? googleSignInOverride,
    OAuthCredential? credentialsOverride,
  }) {
    firebaseAuthInstance = firebaseAuthOverride ?? FirebaseAuth.instance;
    googleSignIn = googleSignInOverride ?? GoogleSignIn(scopes: ['email']);
    credentials = credentialsOverride;
  }

  late final FirebaseAuth firebaseAuthInstance;
  late final GoogleSignIn googleSignIn;
  late final OAuthCredential? credentials;

  User? get currentUser => firebaseAuthInstance.currentUser;

  bool get isAlreadyLoggedIn => currentUser != null;

  String get displayName => currentUser?.displayName ?? '';

  String? get email => currentUser?.email;

  Future<void> logOut() async {
    await firebaseAuthInstance.signOut();
    await googleSignIn.signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = credentials ??
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
    try {
      await firebaseAuthInstance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
