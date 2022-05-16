import 'package:flutter/material.dart';
import 'package:foodster/auth/login/provider/login_provider.dart';
import 'package:foodster/auth/register/view/register_view.dart';
import 'package:foodster/base/base_view.dart';
import 'package:provider/provider.dart';

class ReserPassView extends StatelessWidget {
  const ReserPassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginProvider>(
      object: LoginProvider(context),
      onInit: (model) {},
      onDispose: (model) {},
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Şifremi Unuttum', style: TextStyle(color: Colors.black)),
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
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.purple.shade300,
                      onPressed: (() {
                        value.resetPassword();
                      }),
                      child: const Text(
                        'Şifre sıfırla',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
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
