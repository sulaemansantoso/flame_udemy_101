import 'dart:async';

import 'package:flame/components.dart';
// import 'package:flame/effects.dart';
import 'package:flame_udemy_101/data/gameScore.dart';
import 'package:flame_udemy_101/pages/myFlameGame.dart';
import 'package:flame_udemy_101/ui/livesGroupComponent.dart';
import 'package:flutter/material.dart';

class ScoreComponent extends PositionComponent with HasGameRef<MyFlameGame> {
  late TextComponent _scoreTextComponent;
  late List<SpriteGroupComponent> _liveComponent;

  late GameScore scoreData;

  TextComponent get scoreTextComponent => _scoreTextComponent;

  @override
  FutureOr<void> onLoad() {
    scoreData = GameScore(0, 0);
    _scoreTextComponent = TextComponent(
        position: Vector2(10, 10),
        text: "Score : ${scoreData.score}",
        textRenderer: TextPaint(
            style: const TextStyle(
                fontFamily: "Arial", fontSize: 24, color: Colors.white)));

    game.camera.viewport.add(_scoreTextComponent);
    _liveComponent = [];
    resetLives();

    return super.onLoad();
  }

  void changeScore(int newScore) {
    scoreData.score = newScore;
    scoreTextComponent.text = "Score : ${scoreData.score}";
    // scoreTextComponent
    //     .add(OpacityEffect.by(0.5, EffectController(duration: 0.75)));
  }

  void resetLives() {
    for (int i = 0; i < _liveComponent.length; i++) {
      _liveComponent[i].removeFromParent();
    }
    _liveComponent.clear();

    for (int i = 0; i < 3; i++) {
      _liveComponent
          .add(LivesGroupComponent(Vector2(game.size.x - (50 * i) - 60, 20)));
      game.camera.viewport.add(_liveComponent[_liveComponent.length - 1]);
    }
  }

  void removeLives() {
    if (_liveComponent.isNotEmpty) {
      _liveComponent[_liveComponent.length - 1].removeFromParent();
      _liveComponent.removeLast();
    } else {
      game.gameOver();
    }
  }

  void resetScore() {
    scoreData = GameScore(0, 0);
    scoreTextComponent.text = "Score : ${scoreData.score}";
    _liveComponent = [];
    resetLives();
  }
}
