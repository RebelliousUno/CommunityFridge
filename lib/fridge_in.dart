import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'food_entry.dart';

class FridgeIn extends StatefulWidget {
  FridgeIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FridgeInState();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _FridgeInState extends State<FridgeIn> {
  void submitEntry(AppModel model) {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() == true) {
      var submitted = model.submitFridge(_formKey.currentState?.fields);
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
              const FoodDescriptionWidget("Food Item", "key_food", false),
              const FoodDescriptionWidget("Store Cupboard", "key_store", true),
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
                decoration: const InputDecoration(
                    labelText: 'If Business or Retailer, please specify'),
                validator: (val) {
                  if (_formKey.currentState?.fields['key_source']?.value ==
                          'Business or Retailer' &&
                      (val == null || val.isEmpty)) {
                    return 'Please Specify';
                  }
                  return null;
                },
              ),
              const FoodDescriptionWidget(
                  "Weight in grams", "key_weight", true),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      style: widget.style,
                      onPressed: () {
                        submitEntry(model);
                      },
                      child: const Text("Submit")))
            ],
          ));
    });
  }
}
