import 'package:flutter/material.dart';
import 'package:foodster/auth/login/provider/login_provider.dart';
import 'package:foodster/auth/register/view/register_view.dart';
import 'package:foodster/base/base_view.dart';
import 'package:foodster/reset_pass_view.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          title: const Text('Giriş Yap', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<LoginProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: value.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: value.mailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
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
                    const SizedBox(height: 10),
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
                      decoration: const InputDecoration(
                        labelText: 'Şifre',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.purple.shade300,
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
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const RegisterView(),
                          ),
                        );
                      },
                      child: const Text('Hesap yok mu? Kayıt ol'),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
