import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodster/auth/login/view/login_view.dart';
import 'package:foodster/home/view/favorite_screen.dart';
import 'package:foodster/home/view/home_screen.dart';
import 'package:foodster/home/view/search_screen.dart';

class HomeProvider extends ChangeNotifier {
  late BuildContext context;

  var currentIndex = 0;

  List randomFoodList = [];
  List<String> favoriteFoodList = [];
  var randomFood;

  bool isFavorite = false;

  User? auth;

  Random random = Random();

  bool isLoaiding = false;

  HomeProvider(this.context);

  var formKey = GlobalKey<FormState>();

  setIsLoading(bool b) {
    isLoaiding = b;
    notifyListeners();
  }

  setCurrentIndex(int i) {
    currentIndex = i;
    notifyListeners();
  }

  returnScreen() {
    if (currentIndex == 0) {
      return const HomeScreen();
    } else if (currentIndex == 1) {
      return const SearchScreen();
    } else if (currentIndex == 2) {
      return const FavoriteScreen();
    } else if (currentIndex == 3) {
      logout();
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginView(),
      ),
    );
  }

  getRandomFood() async {
    randomFoodList = [];
    randomFood = null;
    favoriteFoodList.clear();

    setIsLoading(true);
    var food = FirebaseFirestore.instance.collection('food');

    var getFood = await food.get();

    int randomNumber = random.nextInt(getFood.docs.length);

    for (var item in getFood.docs) {
      randomFoodList.add(item);
    }

    randomFood = randomFoodList[randomNumber].data();

    getUser();
  }

  clearRandomFood() {
    randomFoodList.clear();
    randomFood = null;

    notifyListeners();
  }

  getUser() async {
    isFavorite = false;

    auth = FirebaseAuth.instance.currentUser;

    var currentUser = await FirebaseFirestore.instance.collection('user').doc(auth!.uid).get();

    for (var item in currentUser.data()!['favorite']) {
      favoriteFoodList.add(item);
    }

    if (favoriteFoodList.contains(randomFood!['id'].toString())) {
      isFavorite = true;
      notifyListeners();
    }

    setIsLoading(false);
    notifyListeners();
  }

  addFavorite() async {
    var currentUser = await FirebaseFirestore.instance.collection('user').doc(auth!.uid).get();
    var tempcurrentUser = FirebaseFirestore.instance.collection('user').doc(auth!.uid);

    List<String> temp = [];

    if (isFavorite) {
      for (var item in currentUser.data()!['favorite']) {
        temp.add(item);
      }

      if (temp.contains(randomFood!['id'])) {
        isFavorite = false;
        tempcurrentUser.update({
          "favorite": FieldValue.arrayRemove([randomFood!['id']]),
        });
        notifyListeners();
      }
    } else {
      for (var item in currentUser.data()!['favorite']) {
        temp.add(item);
      }

      if (!temp.contains(randomFood!['id'])) {
        isFavorite = true;
        tempcurrentUser.update({
          "favorite": FieldValue.arrayUnion([randomFood!['id']])
        });
        notifyListeners();
      }
    }
  }
}
