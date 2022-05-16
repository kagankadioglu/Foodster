import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodster/auth/login/view/login_view.dart';
import 'package:foodster/home/view/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final User? auth = FirebaseAuth.instance.currentUser;

  Future<bool> isEmailVerified() async {
    var auth = FirebaseAuth.instance.currentUser;

    if (auth == null) {
      print('auth null');
      return false;
    } else {
      print('auth true');
      await auth.reload();
      auth = FirebaseAuth.instance.currentUser;
      return auth!.emailVerified;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: auth == null ? const LoginView() : const HomeView(),
      //home: rooting(),
    );
  }
}
