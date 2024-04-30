import 'dart:async';

import 'package:flame/components.dart';

class LivesGroupComponent extends SpriteGroupComponent with HasGameRef {
  LivesGroupComponent(position)
      : super(position: position, scale: Vector2(0.4, 0.4));

  @override
  FutureOr<void> onLoad() async {
    final sprite_1 = await game.loadSprite('ships/spaceShips_001.png');
    final sprite_2 = await game.loadSprite('ships/spaceShips_009.png');

    sprites = {0: sprite_1, 1: sprite_2};
    current = 0;
    return super.onLoad();
  }
}
