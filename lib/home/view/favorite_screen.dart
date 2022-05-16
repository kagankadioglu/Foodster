import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodster/base/base_view.dart';
import 'package:foodster/food_detay_view.dart';
import 'package:foodster/home/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FavoriteProvider>(
      child: Consumer<FavoriteProvider>(
        builder: (context, _fp, child) {
          return _fp.isLoaiding
              ? const Center(child: CircularProgressIndicator())
              : _fp.foodList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Favori listeniz boş',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _fp.foodList.length,
                      itemBuilder: (context, index) {
                        var foodItem = _fp.foodList[index];
                        return Slidable(
                          key: Key(foodItem.data()['id']),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {
                              _fp.deleteFav(index, foodItem.data()['id']);
                            }),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  _fp.deleteFav(index, foodItem.data()['id']);
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Sil',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  //!
                                },
                                backgroundColor: const Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: 'Paylaş',
                              ),
                            ],
                          ),
                          child: GestureDetector(
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
                          ),
                        );

                        /*  return Dismissible(
                      onDismissed: (direction) {
                        print('KAYDI');
                      },
                      key: Key(foodItem.data()['id']),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          child: Container(
                            //height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(),
                                    child: Image.network(
                                      foodItem.data()['food_image'],
                                      fit: BoxFit.cover,
                                    ),
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
                    ); */
                      },
                    );
        },
      ),
      object: FavoriteProvider(context),
      onInit: (object) => {},
      onDispose: (object) => {},
    );
  }
}
