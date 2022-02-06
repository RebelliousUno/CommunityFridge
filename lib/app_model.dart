import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/src/form_builder_field.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AppModel extends ChangeNotifier {
  String? _sessionId;
  String? _name;
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  String? get name => _name;

  String? get sessionId => _sessionId;

  Map<String, String?> _fridgeEntry = Map();

  Map<String, String?> get fridgeEntry => _fridgeEntry;

  void addFridgeEntry(String key, String? value) {
    _fridgeEntry[key] = value;
  }

  void increaseDate() {
    _selectedDate = _selectedDate.add(Duration(days: 1));
    notifyListeners();
  }

  void decreaseDate() {
    _selectedDate = _selectedDate.subtract(Duration(days: 1));
    notifyListeners();
  }

  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  set name(String? name) {
    _name = name;
    notifyListeners();
  }

  set sessionId(String? sessionId) {
    _sessionId = sessionId;
    notifyListeners();
  }

  Future<bool> submit(
      Map<String, FormBuilderFieldState<FormBuilderField, dynamic>>?
          fields) async {
    var directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    var file = File('$path/fridge.txt');
    var link = file.openWrite(mode: FileMode.append);
    link.write(DateFormat('dd/MM/yyyy').format(_selectedDate));
    link.write('\n');
    fields
        ?.map((key, value) => MapEntry(key, value.value.toString()))
        .forEach((key, value) {
      link.write('$key: $value\n');
    });
    link.write('\n\n');
    link.close();
    return true;
  }
}
