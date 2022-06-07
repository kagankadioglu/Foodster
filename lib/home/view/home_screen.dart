// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodster/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return value.isLoaiding
            ? const Center(child: CircularProgressIndicator())
            : value.randomFood == null
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        value.getRandomFood();
                      },
                      child: WidgetAnimator(
                        incomingEffect: WidgetTransitionEffects.outgoingScaleDown(),
                        atRestEffect: WidgetRestingEffects.size(),
                        child: Container(
                          width: 150,
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade100,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/diet.png'),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Foodste',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green.shade300,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.randomFood['food_name'],
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Stack(
                                children: [
                                  Card(
                                    elevation: 5,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: EdgeInsets.zero,
                                    child: Image.network(value.randomFood['food_image']),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          value.addFavorite();
                                        },
                                        icon: Icon(
                                          value.isFavorite ? Icons.favorite_sharp : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(value.randomFood['food_need']),
                              const SizedBox(height: 10),
                              Text(value.randomFood['food_description']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
