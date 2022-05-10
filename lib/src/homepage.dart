import 'package:flutter/material.dart';
import 'package:pay4me_test/src/widgets/background.dart';
import 'package:pay4me_test/src/model/food.dart';
import 'package:pay4me_test/src/widgets/food_card.dart';
import 'package:pay4me_test/src/widgets/food_type.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double visible = 1;
  bool newPage = true;
  @override
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: Opacity(
            opacity: visible,
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
            ? NotificationListener<DraggableScrollableNotification>(
                onNotification: ((notification) {
                  double visibility = 1 - notification.extent;
                  if (visibility < 0.5) {
                    setState(() {
                      visible = visibility;
                    });
                  } else {
                    setState(() {
                      visible = 1;
                    });
                  }
                  return true;
                }),
                child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  maxChildSize: 0.9,
                  builder: ((context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                              child:
                                  Image.asset('assets/images/rectangle6.png')),
                          const SizedBox(height: 20),
                          const Text(
                            'All Foods',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Expanded(
                            child: GridView.builder(
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
                                        visible = 0;
                                      }),
                                      child: FoodCard(foods: foods[index]),
                                    )),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
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
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),

                        const SizedBox(height: 30),
                        ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: foods.length,

                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => setState(() {
                              newPage = !newPage;
                              visible = 1;
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
        visible < 0.2 && newPage == true
            ? GestureDetector(
                onTap: () => setState(() {
                  newPage = false;
                  visible = 0;
                }),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: 90,
                    width: 90,
                    //transformAlignment: AlignmentGeometry.lerp(a, b, t),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/rectangle8.png')),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    ));
  }
}
