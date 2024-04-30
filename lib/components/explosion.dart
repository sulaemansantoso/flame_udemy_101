import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef {
  double ttl = 1;
  double counter = 0;

  Explosion(position, scale)
      : super(position: position, scale: scale, anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    List<Sprite> spritesAnimationImage = [
      await game.loadSprite("explosion/explosion3.png"),
      await game.loadSprite("explosion/explosion2.png"),
      await game.loadSprite("explosion/explosion1.png"),
      await game.loadSprite("explosion/explosion2.png"),
      await game.loadSprite("explosion/explosion3.png")
    ];

    animation =
        SpriteAnimation.spriteList(spritesAnimationImage, stepTime: 0.3);
    // animation = SpriteAnimation();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    counter += dt;
    if (counter > ttl) {
      removeFromParent();
    }
    super.update(dt);
  }
}
