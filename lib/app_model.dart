import 'dart:core';

import 'package:flutter/foundation.dart';

class AppModel extends ChangeNotifier {
  String? _sessionId;
  String? _name;
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  String? get name => _name;

  String? get sessionId => _sessionId;

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
}
