import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'food_entry.dart';

class FoodOut extends StatefulWidget {
  FoodOut({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FoodOutState();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _FoodOutState extends State<FoodOut> {
  void submitEntry(AppModel model) {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() == true) {
      var submitted = model.submitFoodOut(_formKey.currentState?.fields);
      submitted.then((value) {
        if (value) {
          _formKey.currentState?.reset();
        }
      });
    }
  }
  int _weight = 0;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return FormBuilder(
          key: _formKey,
          onChanged: _calculateWeight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FoodDescriptionWidget("Who", "key_who", false),
                const FoodDescriptionWidget(
                    "Store Cupboard", "key_store", true),
                const FoodDescriptionWidget(
                    "Sandwiches, toasties, salad meals", "key_sandwich", true),
                const FoodDescriptionWidget(
                    "Cakes, puddings, non-bread bakery", "key_cakes", true),
                const FoodDescriptionWidget(
                    "Meat, dairy, eggs", "key_meat", true),
                const FoodDescriptionWidget(
                    "Fruit, veg, bagged salad", "key_salad", true),
                const FoodDescriptionWidget("Bread", "key_bread", true),
                const FoodDescriptionWidget("Other", "key_other", true),
                Align(alignment: Alignment.centerLeft, child: Text("Weight: $_weight")),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                        style: widget.style,
                        onPressed: () {
                          submitEntry(model);
                        },
                        child: const Text("Submit")))
              ]));
    });
  }

  void _calculateWeight() {
    var weightKeys = [
      "key_store",
      "key_sandwich",
      "key_cakes",
      "key_meat",
      "key_salad",
      "key_bread",
      "key_other"
    ];
    int weight = 0;
    for (var element in weightKeys) {
      var value = _formKey.currentState?.fields[element]?.value;
      if (value != null && value != "") weight += int.parse(value);
    }
    setState(() {
        _weight = weight;
    });


  }
}
