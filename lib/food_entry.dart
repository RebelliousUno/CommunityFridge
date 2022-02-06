import 'package:community_fridge/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() == true) {
      var submitted = model.submit(_formKey.currentState?.fields);
      submitted.then((value) {
        if (value) {
          _formKey.currentState?.reset();
        }
      });
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return FormBuilder(
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
              FormBuilderRadioGroup(
                name: 'key_source',
                validator: FormBuilderValidators.required(context),
                options: [
                  'Local Household',
                  'Business or Retailer',
                ]
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
              ),
              FormBuilderTextField(
                name: 'specify',
                decoration: InputDecoration(labelText: 'If Business or Retailer, please specify'),
                validator: (val) {
                  if (_formKey.currentState?.fields['key_source']?.value == 'Business or Retailer' &&
                      (val == null || val.isEmpty)) {
                    return 'Please Specify';
                  }
                  return null;
                },
              ),
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

  FoodDescriptionWidget(
      this._foodDescription, this._modelKey, this._digitsOnly);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return Row(children: [
        Expanded(flex: 8, child: Text(_foodDescription)),
        Expanded(
            flex: 2,
            child: FormBuilderTextField(
              inputFormatters: [
                if (_digitsOnly) FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(border: OutlineInputBorder()),
              keyboardType:
                  _digitsOnly ? TextInputType.number : TextInputType.none,
              name: _modelKey,
            )),
      ]);
    });
  }
}

enum _FoodWho { household, retailer }
