class Player {
  final String name;
  final List<int> score;
  int totalScore = 0;

  Player({
    required this.name,
    required this.score,
  });
  factory Player.create({name}) {
    return Player(
      name: name,
      score: [],
    );
  }
  addScore(int score) {
    this.totalScore += score;
    this.score.add(score);
  }
}
