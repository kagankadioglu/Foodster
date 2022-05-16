import 'package:flutter/material.dart';
import 'package:foodster/auth/login/provider/login_provider.dart';
import 'package:foodster/auth/register/provider/register_provider.dart';
import 'package:foodster/base/base_view.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RegisterProvider>(
      object: RegisterProvider(context),
      onInit: (model) {},
      onDispose: (model) {},
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Kayıt Ol', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<RegisterProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: value.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: value.nameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'İsim',
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Lütfen isim giriniz';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
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
                              value.register();
                            }),
                            child: const Text(
                              'Kayıt Ol',
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