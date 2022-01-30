import 'package:community_fridge/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DateWidget(),
          TabBar(
            controller: _controller,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.amber[800],
            indicatorColor: Colors.amber[800],
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: "Fridge In",
              ),
              Tab(icon: Icon(Icons.directions_transit), text: "Freezer In"),
              Tab(icon: Icon(Icons.directions_bike), text: "Food Out"),
            ],
          ),
          Expanded( child: TabBarView(
            controller: _controller,
            children: [SingleChildScrollView(child:FridgeIn()), Text('Freezer In'), Text('Food Out')],
          ))
        ]);
  }
}

/*
--
Date In (From the Date Widget on the model selectedDate
--
Store Cupboard
Sandwiches/Toasties/Salad Meals
Cakes, Pudding, non-bread bakery,
Meat, Dairy, Eggs
Fruit, Veg, Bagged Salad
Bread,
Other [Checkboxes allowing for multi select OR **text entry fields +ve integers**]
--
Local Household
Business or Retailer [Radio Button]
--
Weight in grams [Text Entry Field - +ve Number]
--
Add Button

 */
class FridgeIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FridgeInState();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _FridgeInState extends State<FridgeIn> {
  void submitEntry(AppModel model) {}
  _FoodWho? _who;

  void foodWhoRadioChanged(_FoodWho? value) {
    setState(() {
      _who = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return Column(
        children: [
          FoodDescriptionWidget("Store Cupboard"),
          FoodDescriptionWidget("Sandwiches, toasties, salad meals"),
          FoodDescriptionWidget("Cakes, puddings, non-bread bakery"),
          FoodDescriptionWidget("Meat, dairy, eggs"),
          FoodDescriptionWidget("Fruit, veg, bagged salad"),
          FoodDescriptionWidget("Bread"),
          FoodDescriptionWidget("Other"),
          RadioListTile<_FoodWho>(
            title: const Text('Local Household'),
            value: _FoodWho.household,
            groupValue: _who,
            onChanged: (_FoodWho? value) {
              foodWhoRadioChanged(value);
            },
          ),
          RadioListTile<_FoodWho>(
            title: const Text('Business or Retailer'),
            value: _FoodWho.retailer,
            groupValue: _who,
            onChanged: (_FoodWho? value) {
              foodWhoRadioChanged(value);
            },
          ),
          FoodDescriptionWidget("Weight in grams"),
          ElevatedButton(
              style: widget.style,
              onPressed: () {
                submitEntry(model);
              },
              child: Text("Submit"))
        ],
      );
    });
  }
}

class FoodDescriptionWidget extends StatelessWidget {
  final String _foodDescription;

  FoodDescriptionWidget(this._foodDescription);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 8, child: Text(_foodDescription)),
      Expanded(
          flex: 2,
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          )),
    ]);
  }
}

enum _FoodWho { household, retailer }
