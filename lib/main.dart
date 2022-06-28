import 'package:flutter/material.dart';
import 'package:flutter_animation_example/animation_non.dart';

import 'animation_1.dart';
import 'animation_2.dart';
import 'dart:developer' as developer;

import 'animation_3.dart';
import 'animation_4.dart';
import 'animation_5.dart';
import 'list/list_animation.dart';

void main() => runApp(const MainHome());

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            navigationButton(ScreenFirst(), "goto no animation"),
            navigationButton(Screen1(), "goto Animation 1"),
            navigationButton(Screen2(), "goto Animation 2"),
            navigationButton(Screen3(), "goto Animation 3"),
            navigationButton(Screen4(), "goto Animation 4"),
            navigationButton(Screen5(), "goto Animation 5"),
            navigationButton(AnimatedListSample(), "goto Animation list"),
          ],
        ),
      ),
    );
  }

  Widget navigationButton(Widget screen, String txt) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Text(txt));
  }
}

void notify(String mes) {
  developer.log(mes, name: 'ManhNQ');
}
