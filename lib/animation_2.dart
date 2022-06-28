import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_example/main.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {
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
            color: Colors.white,
            size: animation.value,
          ),
        ],
      ),
    );
  }
}

Widget actionButton(VoidCallback event, String txt) {
  return ElevatedButton(
      onPressed: () {
        event();
      },
      child: Text(txt));
}
