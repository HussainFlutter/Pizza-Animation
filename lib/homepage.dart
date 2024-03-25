import 'package:flutter/material.dart';
import 'package:test/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final imageController = PageController(viewportFraction: 0.7);
  final textController = PageController();

  late Animation<double> _rotationAnimation;
  late AnimationController _animationController;

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
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _backGroundContainer(mediaQuery),
                _icon(),
                Positioned(
                  top: 80,
                  child: SizedBox(
                    height: 50,
                    width: mediaQuery.width,
                    child: PageView.builder(
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
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: mediaQuery.height * 0.3,
                    width: mediaQuery.width,
                    child: PageView.builder(
                        onPageChanged: (pageIndex) {
                          if (_animationController.isCompleted) {
                            _doAnimation();
                            textController.jumpTo(imageController.offset * 0.2);
                          } else {
                            _animationController.forward();
                            textController.jumpTo(imageController.offset * 0.2);
                          }
                        },
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _backGroundContainer(mediaQuery) => Container(
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
}

Widget _icon() {
  return const Positioned(
    top: 10,
    left: 10,
    child: Icon(
      color: Colors.white,
      Icons.menu,
      size: 34,
    ),
  );
}
