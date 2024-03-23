import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: Scaffold(
        body: _body(),
      ),
    );
  }
}

class _body extends StatelessWidget {
  const _body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("Hello")),
          const Icon(Icons.face),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:[
                Colors.black,
                Colors.cyan,
              ])
            ),
          )
        ],
      ),
    );
  }
}