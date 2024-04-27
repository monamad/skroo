import 'package:flutter/material.dart';
import 'package:skroo/data/player_model.dart';

class PlayersProvider with ChangeNotifier {
  late List<Player> _players;
  int currntRound = 0;
  String message;
  static final List<int> validnumplyers = [2, 3, 4, 5, 6, 7, 8];
  int _numberOfPlayer = 0;
  List<Player> get players => _players;
  PlayersProvider({this.message = ''});

  void setNumberOfPlayer(int? value) {
    if (value != null && validnumplyers.contains(value)) {
      _numberOfPlayer = value;
    } else {
      throw PlayersProvider();
    }
    notifyListeners();
  }

  void addPlayer(List<String> playersname) {
    int emptyIndex = playersname.indexOf('') + 1;

    if (emptyIndex == 0) {
      _players = playersname.map((e) => Player.create(name: e)).toList();
      notifyListeners();
    } else {
      throw PlayersProvider(
          message: 'Please enter the name for player $emptyIndex');
    }
  }

  void addScore(List<String> scores) {
    currntRound++;
    int emptyIndex = scores.indexOf('') + 1;

    if (emptyIndex == 0) {
      scores[setzerotowiner(scores)] = '0';
      for (int i = 0; i < _players.length; i++) {
        _players[i].addScore(int.parse(scores[i]));
      }
      notifyListeners();
    } else {
      throw PlayersProvider(
          message: 'Please enter the name for player $emptyIndex');
    }
  }

  int setzerotowiner(List<String> scores) {
    int minn = int.parse(scores[0]);
    int index = 0;
    for (int i = 1; i < scores.length; i++) {
      if (int.parse(scores[i]) < minn) {
        minn = int.parse(scores[i]);
        index = i;
      }
    }
    return index;
  }
}
// [5,4,2,3]
