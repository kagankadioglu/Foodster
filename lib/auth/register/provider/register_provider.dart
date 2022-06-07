import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  late BuildContext context;

  var nameCtrl = TextEditingController();
  var mailCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  bool isLoading = false;

  setIsLoading(bool b) {
    isLoading = b;
    notifyListeners();
  }

  RegisterProvider(this.context);

  var formKey = GlobalKey<FormState>();

  register() async {
    if (formKey.currentState!.validate()) {
      setIsLoading(true);
      print('111 ');
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mailCtrl.text,
        password: passCtrl.text,
      );
      print(credential.user!.email);

      await credential.user!.sendEmailVerification();

      var userRef = FirebaseFirestore.instance.collection('user').doc(credential.user!.uid);

      await userRef.set({
        'email': mailCtrl.text,
        'name': nameCtrl.text,
        'favorite': [],
        'is_verified': false,
      });
      Navigator.pop(context);
      setIsLoading(false);
    } else {
      print('ERROR');
    }
  }
}
