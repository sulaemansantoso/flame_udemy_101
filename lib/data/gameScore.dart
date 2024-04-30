class GameScore {
  late int _score;
  late int _lives;

  int get score {
    return _score;
  }

  int get lives {
    return _lives;
  }

  set score(int s) {
    _score = s;
  }

  set lives(int n) {
    _lives = n;
  }

  GameScore(this._score, this._lives);
}
