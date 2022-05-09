import 'package:flutter/material.dart';
import 'package:pay4me_test/src/background.dart';
import 'package:pay4me_test/src/food.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool newPage = true;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    )..addStatusListener((status) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: AnimatedBuilder(
          animation: controller!.view,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: Opacity(
                    opacity: newPage ? 1 : 0,
                    child: Container(
                      // duration: const Duration(seconds: 2),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/icon.png'),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    'Find Your \nChow Now',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                newPage
                    ? DraggableScrollableSheet(
                        initialChildSize: 0.5,
                        minChildSize: 0.5,
                        maxChildSize: 0.9,
                        builder: ((context, scrollController) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            // height: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ), // decoration: const BoxDecoration(border: RoundedRectangleBorder()),
                            child: ListView(
                              controller: scrollController,
                              shrinkWrap: true,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //const SizedBox(height: 20),

                                Center(
                                    child: Image.asset(
                                        'assets/images/rectangle6.png')),
                                const Text(
                                  'All Foods',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                const SizedBox(height: 10),
                                GridView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: foods.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 15),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () => setState(() {
                                      newPage = !newPage;
                                    }),
                                    child: FoodCard(
                                      foods: foods[index],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 90,
                                  width: 90,
                                  //transformAlignment: AlignmentGeometry.lerp(a, b, t),
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/rectangle8.png')),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      )
                    : DraggableScrollableSheet(
                        initialChildSize: 0.9,
                        minChildSize: 0.9,
                        maxChildSize: 0.9,
                        builder: ((context, scrollController) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            // height: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ), // decoration: const BoxDecoration(border: RoundedRectangleBorder()),
                            child: ListView(
                              controller: scrollController,
                              shrinkWrap: true,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //const SizedBox(height: 20),

                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Search for stuff',
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      size: 30,
                                    ),
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.cancel_rounded),
                                  ),
                                ),
                                const Divider(thickness: 2),
                                Row(
                                  children: const [
                                    FoodType(name: 'Traditional'),
                                    FoodType(name: 'Salads'),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    FoodType(name: 'International'),
                                    FoodType(name: 'Salads'),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Results",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),

                                const SizedBox(height: 30),
                                ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: foods.length,

                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () => setState(() {
                                      newPage = !newPage;
                                    }),
                                    child: FoodTypeList(
                                      foods: foods[index],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
              ],
            );
          }),
    );
  }
}

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
