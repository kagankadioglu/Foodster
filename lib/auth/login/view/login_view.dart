import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodster/auth/login/provider/login_provider.dart';
import 'package:foodster/auth/register/view/register_view.dart';
import 'package:foodster/base/base_view.dart';
import 'package:foodster/reset_pass_view.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginProvider>(
      object: LoginProvider(context),
      onInit: (model) {},
      onDispose: (model) {},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<LoginProvider>(builder: (context, value, child) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/top1.png'),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/top2.png'),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/diet.png'),
                      ),
                    ),
                  ),
                ),
                /*  loginBody(context, value), */
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/bottom1.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/bottom2.png'),
                  ),
                ),
                loginBody(context, value),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget loginBody(BuildContext context, LoginProvider value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: value.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Email',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: value.mailCtrl,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Lütfen mail giriniz';
                }

                if (!val.contains('@')) {
                  return 'Geçersiz mail adresi';
                }

                return null;
              },
            ),
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Parola',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Lütfen şifre giriniz';
                }

                if (val.length < 6) {
                  return 'Şifre en az 6 karakterden oluşmalıdır';
                }

                return null;
              },
              controller: value.passCtrl,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ReserPassView(),
                    ),
                  );
                },
                child: const Text(
                  'Şifremi unuttum',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 50,
              color: const Color(0xff6E95FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: (() {
                value.login();
              }),
              child: const Text(
                'Giriş yap',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const RegisterView(),
                    ),
                  );
                },
                child: const Text(
                  'Hesabın yok mu? Kayıt ol',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              //minWidth: MediaQuery.of(context).size.width,
              height: 50,
              color: const Color(0xff6E95FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: (() {
                value.googleLogin();
              }),
              child: const Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
