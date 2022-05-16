import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  late BuildContext context;

  List<dynamic> searchFoodList = [];
  List<String> filterInList = [];
  List<String> filterOutList = [];

  User? auth;

  bool isLoaiding = false;

  var currentUser = FirebaseAuth.instance.currentUser;

  SearchProvider(this.context);

  TextEditingController searchCtrl = TextEditingController();
  TextEditingController filterCtrl = TextEditingController();
  TextEditingController filterOutCtrl = TextEditingController();

  setIsLoading(bool b) {
    isLoaiding = b;
    notifyListeners();
  }

  getSearchFood() async {
    searchFoodList.clear();
    setIsLoading(true);

    var getList = await FirebaseFirestore.instance.collection('food').get();

    for (var item in getList.docs) {
      if (item.data()['food_name'].toString().contains(searchCtrl.text)) {
        searchFoodList.add(item);
      }
    }

    setIsLoading(false);
    notifyListeners();
  }

  addFilter() {
    if (!filterInList.contains(filterCtrl.text)) {
      filterInList.add(filterCtrl.text);
    }
    notifyListeners();
  }

  removeFilter(int index) {
    filterInList.removeAt(index);

    notifyListeners();
  }

  addOutFilter() {
    if (!filterOutList.contains(filterOutCtrl.text)) {
      filterOutList.add(filterOutCtrl.text);
    }
    notifyListeners();
  }

  getFilter() async {
    searchFoodList.clear();

    if (filterInList.isNotEmpty) {
      var getList = await FirebaseFirestore.instance.collection('food').where('food_in', arrayContainsAny: filterInList).get();

      for (var item in getList.docs) {
        searchFoodList.add(item);
      }
    }

    getOutFilter();

    // Navigator.pop(context);
    notifyListeners();
  }

  getOutFilter() async {
    if (filterOutList.isNotEmpty) {
      var getList = await FirebaseFirestore.instance.collection('food').get();

      for (var item in getList.docs) {
        if (searchFoodList.contains(item)) {
          searchFoodList.remove(item);
        } else {
          searchFoodList.add(item);
        }
      }
    }

    Navigator.pop(context);
    notifyListeners();
  }
}
