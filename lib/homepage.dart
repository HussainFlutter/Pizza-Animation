import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final pizzaImages = pizzas
        .map(
          (e) => Flexible(
            child: CircleAvatar(
                // // radius: mediaQuery.height * 0.4,
                // backgroundImage: NetworkImage(
                //   e.url,
                // ),
                // child: Image.network(
                //   ,
                //   e.url,
                // ),
                ),
          ),
        )
        .toList();
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: mediaQuery.height / 2,
          width: mediaQuery.width,
          decoration: BoxDecoration(
            color: const Color(0xff07072A),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
              mediaQuery.width * 0.5,
              mediaQuery.height * 0.05,
            )),
          ),
        ),
        Center(
          child: CarouselSlider(
            items: pizzaImages,
            options: CarouselOptions(
              pageSnapping: false,
              //    height: mediaQuery.height * 0.4,
              viewportFraction: 0.9,
              enableInfiniteScroll: false,
            ),
          ),
        ),
        // Center(
        //   child: SizedBox(
        //     height: 100,
        //     width: 100,
        //     child: PageView.builder(
        //         itemCount: 3,
        //         itemBuilder: (context, index) {
        //           return Container(
        //             width: 100,
        //             height: 100,
        //             color: Colors.cyan,
        //           );
        //         }),
        //   ),
        // )
      ],
    ));
  }
}
