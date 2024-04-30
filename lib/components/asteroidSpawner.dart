import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_udemy_101/components/asteroids.dart';

class AsteroidSpawner extends Component with HasGameRef {
  late SpawnComponent spawner;
  @override
  FutureOr<void> onLoad() {
    // spawner = SpawnComponent(
    //     factory: (idx) {
    //       return Asteroids(Vector2(0, 0), Vector2(1, 1));
    //     },
    //     period: 0.5,
    //     area: Rectangle.fromLTWH(10, 10, game.size.x - 20, game.size.y - 20),
    //     within: false);

    spawner = SpawnComponent(
        factory: (index) {
          math.Random r = math.Random();

          int x = r.nextInt(game.size.x.toInt());
          int y = r.nextInt(game.size.y.toInt());

          Vector2 position = Vector2(x.toDouble(), y.toDouble());

          double sf = r.nextDouble() * 0.4;
          Vector2 scale = Vector2(sf, sf);

          return Asteroids(position, scale);
        },
        period: 0.5,
        autoStart: true,
        area: Rectangle.fromLTWH(10, 10, game.size.x - 20, game.size.y - 20),
        within: false);

    game.add(spawner);
    log('adding spawner');
    return super.onLoad();
  }

  void resetSpawner() {
    for (var child in spawner.children) {
      child.removeFromParent();
    }

    spawner.removeAll(spawner.children);
    game.remove(this);
    game.add(AsteroidSpawner());
  }
}
