import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodster/home/view/home_view.dart';
import 'package:foodster/verified_screen.dart';

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
}
