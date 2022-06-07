// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:foodster/base/base_view.dart';
import 'package:foodster/home/provider/home_provider.dart';

import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeProvider>(
      object: HomeProvider(context),
      onInit: (model) {},
      onDispose: (model) {},
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/diet.png'),
              ),
              backgroundColor: Colors.blue.shade50,
              title: Text('Foodster', style: TextStyle(color: Colors.blue.shade300)),
              centerTitle: true,
              actions: [
                homeProvider.randomFood != null
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          homeProvider.clearRandomFood();
                        },
                      )
                    : SizedBox(),
              ],
            ),
            body: homeProvider.returnScreen(),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.blue.shade50,
              selectedItemColor: Colors.blue.shade300,
              unselectedItemColor: Colors.blue.shade100,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: (value) {
                homeProvider.setCurrentIndex(value);
              },
              currentIndex: homeProvider.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  label: 'Anasayfa',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: 'Ara',
                  icon: Icon(Icons.search),
                ),
                BottomNavigationBarItem(
                  label: 'Favoriler',
                  icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  label: 'Çıkış Yap',
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
