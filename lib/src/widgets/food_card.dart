import 'package:flutter/material.dart';
import 'package:pay4me_test/src/model/food.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key? key,
    required this.foods,
  }) : super(key: key);
  final Foods foods;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(foods.image),
          Text(foods.name),
          Text(foods.amount)
        ],
      ),
    );
  }
}
