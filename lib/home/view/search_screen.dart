import 'package:flutter/material.dart';
import 'package:foodster/base/base_view.dart';
import 'package:foodster/food_detay_view.dart';
import 'package:foodster/home/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SearchProvider>(
      child: Consumer<SearchProvider>(
        builder: (context, _sp, child) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _sp.searchCtrl,
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir şeyler girin';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Yemek ara',
                    prefixIcon: IconButton(
                        onPressed: () {
                          bottomSheet(context, _sp);
                        },
                        icon: const Icon(Icons.filter_alt)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _sp.getSearchFood();
                        },
                        icon: const Icon(Icons.search)),
                  ),
                ),
              ),
              _sp.isLoaiding
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: _sp.searchFoodList.length,
                      itemBuilder: (context, index) {
                        var foodItem = _sp.searchFoodList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => FoodDetailView(foodItem: foodItem),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: Image.network(
                                        foodItem.data()['food_image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        foodItem.data()['food_name'],
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        foodItem.data()['food_need'],
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
      object: SearchProvider(context),
      onInit: (object) => {},
      onDispose: (object) => {},
    );
  }

  bottomSheet(BuildContext context, SearchProvider _sp) {
    _sp.filterCtrl.clear();
    _sp.filterOutCtrl.clear();

    showModalBottomSheet(
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _sp.filterCtrl,
                      decoration: InputDecoration(
                        labelText: 'İçerisinde olsun',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _sp.addFilter();
                              });
                            },
                            icon: const Icon(Icons.check)),
                      ),
                    ),
                  ),
                  Wrap(
                    children: List<Widget>.generate(
                        _sp.filterInList.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(3),
                              child: Chip(
                                label: Text(_sp.filterInList[index]),
                                deleteIcon: const Icon(Icons.clear),
                                onDeleted: () {
                                  setState(() {
                                    _sp.removeFilter(index);
                                  });
                                },
                              ),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _sp.filterOutCtrl,
                      decoration: InputDecoration(
                        labelText: 'İçerisinde olmasın',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _sp.addOutFilter();
                              });
                            },
                            icon: const Icon(Icons.check)),
                      ),
                    ),
                  ),
                  Wrap(
                      children: List<Widget>.generate(
                          _sp.filterOutList.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(3),
                                child: Chip(
                                  label: Text(_sp.filterOutList[index]),
                                ),
                              ))),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.green,
                    onPressed: (() {
                      _sp.getFilter();
                    }),
                    child: const Text(
                      'Filtrele',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
      context: context,
    );
  }
}
