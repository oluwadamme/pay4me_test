import 'package:flutter/material.dart';
import 'package:pay4me_test/src/model/food.dart';

class FoodType extends StatelessWidget {
  const FoodType({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFFEFCAF2),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          const SizedBox(width: 20),
          const Icon(
            Icons.cancel_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class FoodTypeList extends StatelessWidget {
  const FoodTypeList({Key? key, required this.foods}) : super(key: key);
  final Foods foods;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(foods.image),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(foods.name),
                  Text(foods.amount),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: Color(0xFFAA00DD),
          ),
        ],
      ),
    );
  }
}
