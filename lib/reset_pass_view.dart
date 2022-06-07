import 'package:flutter/material.dart';
import 'package:foodster/auth/login/provider/login_provider.dart';
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
                forgetPasswordBody(context, value),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget forgetPasswordBody(BuildContext context, LoginProvider value) {
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
            const SizedBox(height: 10),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 50,
              color: const Color(0xff6E95FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
  }
}
