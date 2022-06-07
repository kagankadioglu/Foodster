import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodster/home/view/home_view.dart';
import 'package:foodster/verified_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider extends ChangeNotifier {
  late BuildContext context;

  var mailCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  LoginProvider(this.context);

  var formKey = GlobalKey<FormState>();

  login() async {
    if (formKey.currentState!.validate()) {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mailCtrl.text,
        password: passCtrl.text,
      );

      if (credential.user != null) {
        if (!credential.user!.emailVerified) {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const VerifiedScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeView(),
            ),
          );
        }
      }
    } else {
      print('ERROR');
    }
  }

  resetPassword() async {
    print(mailCtrl.text);
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: mailCtrl.text,
      );
    }
  }

  googleLogin() async {
    var us = await signInWithGoogle();

    if (us.user != null) {
      var userRef = FirebaseFirestore.instance.collection('user').doc(us.user!.uid);

      if (us.additionalUserInfo!.isNewUser) {
        await userRef.set({
          'email': us.user!.email,
          'name': us.user!.displayName,
          'favorite': [],
          'is_verified': false,
        });
      }

      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomeView(),
        ),
      );
    } else {
      print('ERROR');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
