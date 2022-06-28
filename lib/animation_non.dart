import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenFirst extends StatefulWidget {
  const ScreenFirst({super.key});

  @override
  _ScreenFirstState createState() => _ScreenFirstState();
}

class _ScreenFirstState extends State<ScreenFirst> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            actionButton(() {}, "Change size"),
            Icon(
              Icons.accessibility_new,
              color: Colors.white,
              size: 100,
            ),
          ],
        ),
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
