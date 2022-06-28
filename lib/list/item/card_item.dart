import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewItem extends StatelessWidget {

  final Animation<double> animation;
  final VoidCallback? onClick;
  final int item;
  final bool selected;

  const ViewItem({
    Key? key,
    this.onClick,
    this.selected = false,
    required this.animation,
    required this.item,
  }) : assert(item >= 0),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onClick,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
