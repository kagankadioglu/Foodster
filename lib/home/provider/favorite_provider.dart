import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  late BuildContext context;

  List<String> favoriteFoodList = [];
  List<dynamic> foodList = [];

  bool isFavorite = false;

  User? auth;

  bool isLoaiding = false;

  var currentUser = FirebaseAuth.instance.currentUser;

  FavoriteProvider(this.context) {
    getUserFavoriteList();
  }

  setIsLoading(bool b) {
    isLoaiding = b;
    notifyListeners();
  }

  getUserFavoriteList() async {
    setIsLoading(true);
    var getList = await FirebaseFirestore.instance.collection('user').doc(currentUser!.uid).get();

    for (var item in getList.data()!['favorite']) {
      favoriteFoodList.add(item);
    }

    getFoods();
    notifyListeners();
  }

  getFoods() async {
    var getList = await FirebaseFirestore.instance.collection('food').get();

    for (var item in getList.docs) {
      if (favoriteFoodList.contains(item.data()['id'])) {
        foodList.add(item);
      }
    }

    setIsLoading(false);
    notifyListeners();
  }

  deleteFav(int index, String foodId) async {
    foodList.removeAt(index);

    var getList = FirebaseFirestore.instance.collection('user').doc(currentUser!.uid);

    getList.update({
      "favorite": FieldValue.arrayRemove([foodId]),
    });

    notifyListeners();
  }
}
