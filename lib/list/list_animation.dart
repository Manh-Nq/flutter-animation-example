import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ListManager.dart';
import 'item/card_item.dart';

class AnimatedListSample extends StatefulWidget {
  const AnimatedListSample({Key? key}) : super(key: key);

  @override
  State<AnimatedListSample> createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListManager<int> _manager;
  int? _selectedItem;
  late int _nextItem;

  @override
  void initState() {
    super.initState();
    _manager = ListManager<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2, 3, 4, 5, 6, 7,8],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 9;
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _manager[index],
      selected: _selectedItem == _manager[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _manager[index] ? null : _manager[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index =
        _selectedItem == null ? _manager.length : _manager.indexOf(_selectedItem!);
    _manager.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _manager.removeAt(_manager.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _manager.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}



