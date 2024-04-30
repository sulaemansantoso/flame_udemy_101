import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_udemy_101/components/Ship.dart';
import 'package:flame_udemy_101/components/asteroidSpawner.dart';
import 'package:flame_udemy_101/components/parallaxStar.dart';
import 'package:flame_udemy_101/ui/scoreComponent.dart';

class MyFlameGame extends FlameGame
    with PanDetector, TapDetector, HasCollisionDetection {
  MyFlameGame() {}

  @override
  Color backgroundColor() {
    return const Color.fromARGB(239, 61, 89, 171);
  }

  late Ship player;
  late ParallaxStar para;
  late ScoreComponent scoreHUD;
  late Vector2 origin;
  late Vector2 target;
  late Vector2 _direction;
  double speed = 5.0;

  Vector2 get direction {
    return _direction;
  }

  @override
  void onTapDown(TapDownInfo info) {
    player.shoot(info.eventPosition.global);
  }

  void getMeteorKill() {
    scoreHUD.changeScore(scoreHUD.scoreData.score + 10);
  }

  void gameOver() {
    pauseEngine();
    overlays.add("gameover");
  }

  void resetGame() {
    overlays.remove('gameover');
    scoreHUD.resetScore();
    player.resetGameplay();
    para.resetGameplay();
    resumeEngine();
  }

  void removeLives() {
    scoreHUD.removeLives();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // player.lookAt(info.eventPosition.global);
    // player.angle += math.pi; //
    // direction = info.eventPosition.global - origin;
    // direction.normalize();

    // para.changeSpeed(direction * 5);
    // player.position.add(direction); //
    // origin = info.eventPosition.global;
    player.panUpdate(info);
  }

  @override
  void update(double dt) {
    player.update(dt);
    para.changeSpeedBasedPlayer(player);

    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() {
    para = ParallaxStar();
    add(para);
    player = Ship();
    add(player);
    add(AsteroidSpawner());

    add(scoreHUD = ScoreComponent());

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   add(BlastParticle(Vector2(100, 100)));
    // });
  }
}
