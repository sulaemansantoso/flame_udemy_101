import 'dart:async';
// import 'dart:io';
// import 'dart:developer';
import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bullets extends SpriteComponent with HasGameRef {
  Vector2 direction;
  double ttl = 100;
  double speed = 20;
  Bullets(position, this.direction, anglez) : super(position: position) {
    angle = anglez - math.pi;
    direction = direction.normalized();
    // log("$direction");
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('bullets/spaceMissiles_015.png');

    add(RectangleHitbox(collisionType: CollisionType.active));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    ttl--;
    if (ttl <= 0) {
      removeFromParent();
    }
    position.add(direction * speed);

    super.update(dt);
  }
}
