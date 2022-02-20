import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'food_entry.dart';

class FreezerIn extends StatefulWidget {
  FreezerIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FreezerInState();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _FreezerInState extends State<FreezerIn> {
  void submitEntry(AppModel model) {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() == true) {
      var submitted = model.submitFreezer(_formKey.currentState?.fields);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FoodDescriptionWidget("Food Item", "key_food", false),
                FormBuilderDateTimePicker(
                    name: "key_prepared",
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                    format: DateFormat("dd/MM/yyyy"),
                    inputType: InputType.date,
                    decoration:
                        const InputDecoration(labelText: "Date Prepared")),
                FormBuilderDateTimePicker(
                    name: "key_original_use_by",
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                    format: DateFormat("dd/MM/yyyy"),
                    inputType: InputType.date,
                    onChanged: (value) {
                      _formKey.currentState?.fields["key_new_use_by"]
                          ?.didChange(value?.add(const Duration(days: 28 * 3)));
                    },
                    decoration: const InputDecoration(
                        labelText: "Original Use By Date")),
                FormBuilderDateTimePicker(
                    name: "key_new_use_by",
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                    format: DateFormat("dd/MM/yyyy"),
                    inputType: InputType.date,
                    decoration:
                        const InputDecoration(labelText: "New Use By Date")),
                const FoodDescriptionWidget("Quantity", "key_quantity", false),
                const FoodDescriptionWidget(
                    "Weight in grams", "key_weight", true),
                const FoodDescriptionWidget(
                    "Additional Details", "key_additional_details", false),
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
}
