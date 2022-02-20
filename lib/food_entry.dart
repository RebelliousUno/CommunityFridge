import 'package:community_fridge/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'date_widget.dart';
import 'food_model.dart';
import 'food_out.dart';
import 'freezer_in.dart';
import 'fridge_in.dart';

class FoodEntryWidget extends StatefulWidget {
  const FoodEntryWidget({Key? key}) : super(key: key);

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
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DateWidget(),
          TabBar(
            controller: _controller,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.amber[800],
            indicatorColor: Colors.amber[800],
            tabs: const [
              Tab(
                icon: Icon(Icons.directions_car),
                text: "Fridge In",
              ),
              Tab(icon: Icon(Icons.directions_transit), text: "Freezer In"),
              Tab(icon: Icon(Icons.directions_bike), text: "Food Out"),
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: _controller,
            children: [
              SingleChildScrollView(child: FridgeIn()),
              SingleChildScrollView(child: FreezerIn()),
              SingleChildScrollView(child: FoodOut())
            ],
          ))
        ]);
  }
}

class FoodDropDownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(name: "Food Type", items: FoodType.values.map((e) => DropdownMenuItem(child: Text(e.string))).toList());
  }
}

class FoodDescriptionWidget extends StatelessWidget {
  final String _foodDescription;
  final String _modelKey;
  final bool _digitsOnly;

  const FoodDescriptionWidget(
      this._foodDescription, this._modelKey, this._digitsOnly,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        inputFormatters: [
          if (_digitsOnly) FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(labelText: _foodDescription),
        keyboardType: _digitsOnly ? TextInputType.number : TextInputType.text,
        name: _modelKey,
      );
  }
}
