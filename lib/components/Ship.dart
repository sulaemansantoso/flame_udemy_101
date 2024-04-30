import 'dart:async';

import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/rendering.dart';
import 'package:flame_udemy_101/components/asteroids.dart';
import 'package:flame_udemy_101/components/bullets.dart';
import 'package:flame_udemy_101/components/explosion.dart';
import 'package:flame_udemy_101/pages/myFlameGame.dart';
import 'package:flutter/material.dart' as material;

class Ship extends SpriteComponent
    with HasGameRef<MyFlameGame>, CollisionCallbacks {
  late Vector2 origin;
  late Vector2 target;
  late Vector2 direction;
  bool isShooting = false;
  bool isBeingHit = false;
  double speed = 5.0;
  double shootCooldown = 0.25;
  double shootTimer = 0;
  double hitTimer = 0;
  double hitCooldown = 1.5;

  void shoot(Vector2 Target) {
    target = Target;
    setTarget(target);

    if (isShooting == false) {
      isShooting = true;
      shootTimer = 0;
      var bullets = Bullets(position, direction, angle);
      game.add(bullets);
      //spawn bullets.
    }
  }

  Ship() {
    origin = Vector2(0, 0);
    direction = Vector2(0, 0);
    target = Vector2(0, 0);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Asteroids) && (!isBeingHit)) {
      //ship hurt, instantiate explosion
      //reduce lives

      isBeingHit = true;
      game.removeLives();
      game.add(Explosion(intersectionPoints.first, Vector2(1, 1)));
      decorator.addLast(PaintDecorator.tint(material.Colors.red));
      decorator.addLast(PaintDecorator.blur(2));
      hitTimer = 0;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    position = Vector2(game.size.x / 2, game.size.y / 2);
    anchor = Anchor.center;
    Image spriteImage = await Flame.images.load("ships/spaceShips_001.png");
    sprite = Sprite(spriteImage);

    add(CircleHitbox(
        radius: spriteImage.width * 0.3, collisionType: CollisionType.active));
  }

  void setTarget(Vector2 Target) {
    lookAt(Target);
    angle += math.pi;

    direction = target - position;
    direction.normalize();
  }

  void panUpdate(DragUpdateInfo info) {
    target = info.eventPosition.global;
    setTarget(target);
  }

  @override
  void update(double dt) {
    shootTimer += dt;
    if (shootTimer > shootCooldown) {
      isShooting = false;
    }

    hitTimer += dt;
    if (hitTimer > hitCooldown) {
      isBeingHit = false;
      decorator.removeLast();
      decorator.removeLast();
    }
    if ((target - position).length > speed) {
      position.add(direction * speed);
    } else {
      direction = Vector2(0, 0);
    }
    super.update(dt);
  }

  void resetGameplay() {
    position = Vector2(game.size.x / 2, game.size.y / 2);
    isShooting = false;
    isBeingHit = false;
    hitTimer = 0;
    angle = 0;
    shootTimer = 0;
    direction = Vector2(0, 0);
    target = Vector2(0, 0);
  }
}
