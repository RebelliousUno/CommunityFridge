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
          Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  SingleChildScrollView(child: FridgeIn()),
                  Text('Freezer In'),
                  Text('Food Out')
                ],
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
  void submitEntry(AppModel model) {
    model.fridgeEntry;
  }
  _FoodWho? _who;

  void foodWhoRadioChanged(_FoodWho? value) {
    setState(() {
      _who = value;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return Form(
          key: _formKey,
          child: Column(
            children: [
              FoodDescriptionWidget("Store Cupboard", "key_store", true),
              FoodDescriptionWidget(
                  "Sandwiches, toasties, salad meals", "key_sandwich", true),
              FoodDescriptionWidget(
                  "Cakes, puddings, non-bread bakery", "key_cakes", true),
              FoodDescriptionWidget("Meat, dairy, eggs", "key_meat", true),
              FoodDescriptionWidget(
                  "Fruit, veg, bagged salad", "key_salad", true),
              FoodDescriptionWidget("Bread", "key_bread", true),
              FoodDescriptionWidget("Other", "key_other", true),
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
              if (_who == _FoodWho.retailer)
                FoodDescriptionWidget("Retailer?", "key_retailer", false),
              FoodDescriptionWidget("Weight in grams", "key_weight", true),
              ElevatedButton(
                  style: widget.style,
                  onPressed: () {
                    submitEntry(model);
                  },
                  child: Text("Submit"))
            ],
          ));
    });
  }
}

class FoodDescriptionWidget extends StatelessWidget {
  final String _foodDescription;
  final String _modelKey;
  final bool _digitsOnly;

  FoodDescriptionWidget(this._foodDescription, this._modelKey,
      this._digitsOnly);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return Row(children: [
        Expanded(flex: 8, child: Text(_foodDescription)),
        Expanded(
            flex: 2,
            child: TextFormField(
              onSaved: (String? value) {
                model.addFridgeEntry(_modelKey, value);
              },
              inputFormatters: [
                if (_digitsOnly) FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(border: OutlineInputBorder()),
              keyboardType: _digitsOnly ? TextInputType.number : TextInputType
                  .none,
            )),
      ]);
    });
  }
}

enum _FoodWho { household, retailer }
