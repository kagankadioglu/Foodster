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
              backgroundColor: Colors.purple.shade300,
              title: const Text('Foodster'),
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
              backgroundColor: Colors.purple.shade300,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: (value) {
                homeProvider.setCurrentIndex(value);
              },
              currentIndex: homeProvider.currentIndex,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
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
