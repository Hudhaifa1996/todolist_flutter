import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  late bool isOneButton;
  late TextEditingController myController;
  late TextEditingController myController2;
  List<int> _randomColor = [];
  List<dynamic> _todos = [];

  String _accessToken = '';
  String _title = '';
  String _description = '';
  String _waitingType = '';
  String _id = '';
  int _gestureIndex = 0;

  void setRandomColor(List<int> randomColor) {
    _randomColor = randomColor;
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    notifyListeners();
  }

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  void setTodos(List<dynamic> todos) {
    _todos = todos;
    notifyListeners();
  }

  void setWaitingType(String waitingType) {
    _waitingType = waitingType;
    notifyListeners();
  }

  void setGestureIndex(int gestureIndex) {
    _gestureIndex = gestureIndex;
    notifyListeners();
  }

  List<dynamic> get getTodos => _todos;

  String get getTitle => _title;

  String get getDescription => _description;

  String get getId => _id;

  String get getAccessToken => _accessToken;

  String get getWaitingType => _waitingType;

  randomColor(int index) {
    return _randomColor[_todos.length - 1 - index];
  }

  randomColorDelete() {
    _randomColor.removeAt(_todos.length - 1 - _gestureIndex);
  }
}
