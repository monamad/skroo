import 'package:flutter/material.dart';
import 'package:skroo/data/player_model.dart';

class PlayersProviderException implements Exception {
  final String message;

  PlayersProviderException({required this.message});
}

class PlayersProvider with ChangeNotifier {
  late List<Player> _players;
  int currntRound = 0;
  String message;
  static final List<int> validnumplyers = [2, 3, 4, 5, 6, 7, 8];
  int _numberOfPlayer = 0;
  List<Player> get players => _players;
  PlayersProvider({this.message = ''});
  get numberOfPlayer => _numberOfPlayer;
  void setNumberOfPlayer(int? value) {
    if (value != null && validnumplyers.contains(value)) {
      _numberOfPlayer = value;
    } else {
      throw PlayersProviderException(
          message: 'Number of players must be between 2 and 8');
    }
    notifyListeners();
  }

  void addPlayer(List<String> playersname) {
    int emptyIndex = playersname.indexOf('') + 1;

    if (emptyIndex == 0) {
      _players = playersname.map((e) => Player.create(name: e)).toList();
      notifyListeners();
    } else {
      throw PlayersProviderException(
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
      throw PlayersProviderException(
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

  Player winner() {
    Player winer = _players[0];
    for (int i = 1; i < _players.length; i++) {
      if (_players[i].totalScore > winer.totalScore) {
        winer = _players[i];
      }
    }
    return winer;
  }

  void reset() {
    _players.clear();
    currntRound = 0;
    message = '';
    _numberOfPlayer = 0;
    notifyListeners();
  }
}
