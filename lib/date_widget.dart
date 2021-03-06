import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  void datePicker(AppModel model) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: model.selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null && picked != model.selectedDate) {
      model.selectedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return Row(
        children: [
          IconButton(
              onPressed: model.decreaseDate,
              icon: const Icon(Icons.chevron_left)),
          Expanded(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(DateFormat('d MMMM yyyy').format(model.selectedDate)),
            IconButton(
                onPressed: () {
                  datePicker(model);
                },
                icon: const Icon(Icons.calendar_today))
          ])),
          IconButton(
              onPressed: model.increaseDate,
              icon: const Icon(Icons.chevron_right))
        ],
      );
    });
  }
}
