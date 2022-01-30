
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_model.dart';

class DateWidget extends StatefulWidget {
  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  void decreaseDay() {
    setState(() {
      AppModel.decreaseDate();
    });
  }

  void increaseDay() {
    setState(() {
      AppModel.increaseDate();
    });
  }

  void datePicker() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: AppModel.getDate(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null && picked != AppModel.getDate()) {
      setState(() {
        AppModel.setDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: decreaseDay, icon: Icon(Icons.chevron_left)),
        Text(DateFormat('dd/MM/yyyy').format(AppModel.getDate())),
        IconButton(onPressed: datePicker, icon: Icon(Icons.calendar_today)),
        IconButton(onPressed: increaseDay, icon: Icon(Icons.chevron_right))
      ],
    );
  }
}