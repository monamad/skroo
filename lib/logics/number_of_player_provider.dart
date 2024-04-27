import 'package:flutter/material.dart';

class NumberOfPlayerException implements Exception {
  final String message;

  NumberOfPlayerException(
      [this.message = 'Number of players must be between 2 and 8']);
}

class NumberOfPlayerProvider extends ChangeNotifier {
  static final List<int> validnumplyers = [2, 3, 4, 5, 6, 7, 8];
  int _numberOfPlayer = 0;

  int get numberOfPlayer => _numberOfPlayer;

  void setNumberOfPlayer(int? value) {
    if (value != null && validnumplyers.contains(value)) {
      _numberOfPlayer = value;
    } else {
      throw NumberOfPlayerException();
    }
    notifyListeners();
  }
}
