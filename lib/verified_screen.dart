import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodster/home/view/home_screen.dart';

import 'home/view/home_view.dart';

class VerifiedScreen extends StatefulWidget {
  const VerifiedScreen({Key? key}) : super(key: key);

  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  bool _isUserEmailVerified = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    Future(() async {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        await FirebaseAuth.instance.currentUser!.reload();
        var user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          setState(() {
            _isUserEmailVerified = user.emailVerified;
          });
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeView(),
            ),
          );
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: Text('Emil aktif ediliyor'),
          ),
        ],
      ),
    );
  }
}
