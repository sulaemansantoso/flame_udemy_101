import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flame_udemy_101/components/blastParticle.dart';
import 'package:flame_udemy_101/pages/myFlameGame.dart';

class Asteroids extends SpriteComponent
    with HasGameRef<MyFlameGame>, CollisionCallbacks {
  late Vector2 direction;
  late double speed;
  bool isDead = false;

  Asteroids(position, scale)
      : super(position: position, scale: scale, anchor: Anchor.center);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    game.add(BlastParticle(position, scale));
    game.getMeteorKill();
    removeFromParent();
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('/meteor/spaceMeteors_001.png');

    math.Random r = math.Random();
    double x = r.nextDouble() * 2 - 1;
    double y = r.nextDouble() * 2 - 1;

    direction = Vector2(x, y);
    speed = r.nextDouble() * 5;

    double tintFactor = (0.4 - scale.x) / 0.4;
    double tintValue = (tintFactor * 100);

    decorator.addLast(PaintDecorator.tint(Color.fromARGB(
        50, tintValue.toInt(), tintValue.toInt(), tintValue.toInt())));

    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.add(direction * speed);

    if ((game.size - position).length > game.size.x * 2) {
      removeFromParent();
    }
    super.update(dt);
  }
}
