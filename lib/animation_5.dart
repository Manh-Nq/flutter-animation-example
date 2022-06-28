import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_example/main.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> with SingleTickerProviderStateMixin {
  var _size = 100.0;
  bool isShow = false;
  late Animation<double> animation;
  late AnimationController controller;

  void _changeSize() {
    setState(() {
      if (_size < 400) {
        _size += 100.0;
      } else if (_size < 100) {
        _size = 100.0;
      } else {
        _size -= 100.0;
      }
    });
  }

  void _changeShow() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 1, end: 3).animate(controller)
      ..addStatusListener((status) {
        notify("$status");
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _animatedFoo(),
              SizedBox(
                height: 50,
              ),
              _tweenBuilder(),
              SizedBox(
                height: 50,
              ),
              _fooAnimation(animation, () {
                if (controller.isCompleted) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              }),
              _crossFadeAnimatedFoo(isShow, () {
                _changeShow();
              }),
            ],
          )),
    );
  }

  Widget _animatedFoo() {
    return AnimatedContainer(
      color: Colors.blue,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInCirc,
      width: _size,
      height: _size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(() {
            _changeSize();
          }, "Change size"),
        ],
      ),
    );
  }

  Widget _crossFadeAnimatedFoo(bool isShow, VoidCallback change) {
    return AnimatedCrossFade(
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(() {
            change();
          }, "hello"),
        ],
      ),
      secondChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(() {
            change();
          }, "byebye"),
        ],
      ),
      duration: Duration(milliseconds: 1000),
      crossFadeState: isShow == false
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }

  Widget _tweenBuilder() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 90, end: 270),
      builder: (context, data, child) {
        return Transform.rotate(angle: data as double, child: child);
      },
      duration: Duration(milliseconds: 10000),
      curve: Curves.easeInCirc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(() {}, "Change size"),
        ],
      ),
    );
  }

  Widget _fooAnimation(Animation<double> scale, VoidCallback func) {
    return ScaleTransition(
      scale: scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(() {
            func();
          }, "Change size"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget actionButton(VoidCallback event, String txt) {
    return ElevatedButton(
        onPressed: () {
          event();
        },
        child: Text(txt));
  }
}
