import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future<void> handleGoogleSignUp() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Check if the email is already associated with an existing account
      final signInMethods =
          await _auth.fetchSignInMethodsForEmail(googleUser.email);
      if (signInMethods.isNotEmpty) {
        print("Account already in use");
        return;
      }

      // Create a new account with the Google credentials
      await FirebaseAuth.instance.signInWithCredential(credential);

      // User sign up successful, proceed with app flow
    } catch (e) {
      // Handle sign-up errors or exceptions
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
