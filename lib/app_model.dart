import 'dart:core';

class AppModel {
  static String? _sessionId;
  static String? _name;
  static DateTime _selectedDate = DateTime.now();

  static DateTime getDate() {
    return _selectedDate;
  }

  static increaseDate() {
    _selectedDate = _selectedDate.add(Duration(days: 1));
  }

  static decreaseDate() {
    _selectedDate = _selectedDate.subtract(Duration(days: 1));
  }

  static setDate(DateTime date) {
    _selectedDate = date;
  }

  static String? getName() {
    return _name;
  }

  static String? setName(String name) {
    _name = name;
  }

  static String? getSessionId() {
    return _sessionId;
  }

  static setSessionId(String sessionId) {
    _sessionId = sessionId;
  }
}
