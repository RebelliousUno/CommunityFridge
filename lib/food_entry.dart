import 'package:flutter/material.dart';

import 'date_widget.dart';

class FoodEntryWidget extends StatefulWidget {
  @override
  State<FoodEntryWidget> createState() => _FoodEntryState();
}

class _FoodEntryState extends State<FoodEntryWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      DateWidget(),
      Container(
        child: TabBar(
          controller: _controller,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
      Container(
          height: 300,
          child: TabBarView(
            controller: _controller,
            children: [Text('Food In'), Text('Freezer In'), Text('Food Out')],
          )),
    ]);
  }
}
