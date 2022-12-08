import 'dart:html';

import 'package:meeting_web_app/modules/authentication/wrapper/auth_plugin/auth_plugin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGoogle implements AuthLogin {
  static final AuthGoogle _instance = AuthGoogle.internal();
  late GoogleAuthProvider _googleProvider;
  UserCredential? _userCredential;
  
  factory AuthGoogle() {
    return _instance;
  }

  @override
  AuthGoogle.internal() {
    GoogleAuthProvider _googleProvider = GoogleAuthProvider();
    _googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    _googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
  }

  @override
  Future<AuthResult> login() async {
    await FirebaseAuth.instance.signOut(); //force signout
    try{
      final UserCredential googleSignInAccount  = await FirebaseAuth.instance.signInWithPopup(_googleProvider);
      if (googleSignInAccount.user == null) {
        return AuthResult(LoginStatus.cancelledByUser, null);
      }
      return AuthResult(LoginStatus.loggedIn, googleSignInAccount.credential?.accessToken);
    } catch(e) {
      return AuthResult(LoginStatus.error, null);
    }
  }

  Future<void> logout () {
    return FirebaseAuth.instance.signOut();
  }
}