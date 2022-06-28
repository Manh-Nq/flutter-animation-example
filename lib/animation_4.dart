import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_example/main.dart';

import 'animation_2.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 100, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          //notify to ui when animation change value
          notify("listener");
        });
      })
      ..addStatusListener((status) {
        //notify when animation rewards, complete
        notify("$status");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LogoAnimation((isComplete) {
      if (isComplete) {
        controller.reverse();
      } else {
        controller.forward();
      }
    }, animation: animation));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

typedef ActionCallback = void Function(bool data);

class LogoAnimation extends AnimatedWidget {
  final ActionCallback action;

  const LogoAnimation(this.action,
      {super.key, required Animation<double> animation})
      : super(listenable: animation);

  static final _size = Tween(begin: 100.0, end: 300.0);
  static final _color = ColorTween(begin: Colors.blue, end: Colors.red);

  @override
  Widget build(BuildContext context) {
    var animation = listenable as Animation<double>;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(() {
            action(animation.isCompleted);
          }, "Change size"),
          Icon(
            Icons.adb,
            color: _color.evaluate(animation),
            size: 100,
          ),
        ],
      ),
    );
  }
}
