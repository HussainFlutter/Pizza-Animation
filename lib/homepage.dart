import 'package:flutter/material.dart';
import 'package:test/model.dart';

enum PizzaSizes { S, M, L }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final imageController = PageController(viewportFraction: 0.7);
  final textController = PageController();
  final descriptionController = PageController();

  late Animation<double> _rotationAnimation;
  late AnimationController _animationController;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _rotationAnimation =
        Tween<double>(begin: 0, end: -1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));
    imageController.addListener(() {
      textController.jumpTo(imageController.offset * 0.13);
      descriptionController.jumpTo(imageController.offset * 0.69);
    });
  }

  _doAnimation() {
    _rotationAnimation = Tween<double>(
            begin: _rotationAnimation.value, end: _rotationAnimation.value - 1)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    imageController.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _backGroundContainer(mediaQuery),
                _icon(),
                _titlePageViewBuilder(mediaQuery),
                _imagePageViewBuilder(mediaQuery),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _priceAndDescription(mediaQuery),
            _pizzaSizes(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: Text(
            "Order Now",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onPageChange(int pageIndex) {
    if (_animationController.isCompleted) {
      _doAnimation();
    } else {
      _animationController.forward();
    }
  }

  Widget _priceAndDescription(Size mediaQuery) => SizedBox(
        height: mediaQuery.height * 0.2,
        width: mediaQuery.width,
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: descriptionController,
            scrollDirection: Axis.vertical,
            itemCount: pizzas.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      "\$${pizzas[index].price.toString()}",
                      textScaler: const TextScaler.linear(2),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        pizzas[index].description,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          // overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      );

  Widget _icon() => const Positioned(
        top: 10,
        left: 10,
        child: Icon(
          color: Colors.white,
          Icons.menu,
          size: 34,
        ),
      );

  Widget _backGroundContainer(Size mediaQuery) => Container(
        height: mediaQuery.height / 2,
        width: mediaQuery.width,
        decoration: BoxDecoration(
            color: const Color(0xff07072A),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                mediaQuery.width * 1,
                mediaQuery.height * 0.1,
              ),
            )),
      );

  _titlePageViewBuilder(Size mediaQuery) => Positioned(
        top: 80,
        child: SizedBox(
          height: mediaQuery.height * 0.035,
          width: mediaQuery.width,
          child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: textController,
              itemCount: pizzas.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    pizzas[index].name,
                    textScaler: const TextScaler.linear(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
        ),
      );

  _pizzaSizes() => Row(
        children: PizzaSizes.values.map((e) {
          return OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) =>
                    e.index == selectedIndex ? Colors.black : Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                selectedIndex = e.index;
              });
            },
            child: Text(e.name),
          );
        }).toList(),
      );

  _imagePageViewBuilder(Size mediaQuery) => Positioned(
        bottom: 0,
        child: SizedBox(
          height: mediaQuery.height * 0.3,
          width: mediaQuery.width,
          child: PageView.builder(
              onPageChanged: (pageIndex) => _onPageChange(pageIndex),
              controller: imageController,
              itemCount: pizzas.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Image.asset(
                        height: mediaQuery.height * 0.25,
                        pizzas[index].url,
                      ),
                    );
                  },
                );
              }),
        ),
      );
}
