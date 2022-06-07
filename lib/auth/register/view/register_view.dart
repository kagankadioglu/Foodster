import 'package:flutter/material.dart';
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
        body: Consumer<RegisterProvider>(builder: (context, value, child) {
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
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ),
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
                registerBody(context, value),
              ],
            ),
          );
        }),
        /* backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Kayıt Ol', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<RegisterProvider>(
          builder: (context, value, child) => registerBody(context, value),
        ), */
      ),
    );
  }

  Widget registerBody(BuildContext context, RegisterProvider value) {
    return value.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: value.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'İsim',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: value.nameCtrl,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Lütfen isim giriniz';
                        }

                        return null;
                      },
                    ),
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
                          return 'Lütfen parola giriniz';
                        }
                        if (val.length < 6) {
                          return 'Parola en az 6 karakterden oluşmalıdır';
                        }
                        return null;
                      },
                      controller: value.passCtrl,
                      obscureText: true,
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
                        value.register();
                      }),
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
          );
  }
}
