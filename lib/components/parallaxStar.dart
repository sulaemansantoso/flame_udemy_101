import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_udemy_101/components/Ship.dart';
import 'package:flutter/painting.dart';

class ParallaxStar extends ParallaxComponent with HasGameRef {
  final _parallelimage = [
    ParallaxImageData('parallax/bkgd_0.png'),
    ParallaxImageData('parallax/bkgd_1.png'),
    ParallaxImageData('parallax/bkgd_2.png'),
    ParallaxImageData('parallax/bkgd_3.png'),
    ParallaxImageData('parallax/bkgd_4.png'),
    ParallaxImageData('parallax/bkgd_5.png'),
    ParallaxImageData('parallax/bkgd_6.png'),
  ];

  @override
  FutureOr<void> onLoad() async {
    parallax = await game.loadParallax(_parallelimage,
        baseVelocity: Vector2(0, 0),
        velocityMultiplierDelta: Vector2(1.5, 1.5),
        repeat: ImageRepeat.repeat);
  }

  void changeSpeed(direction) {
    parallax!.baseVelocity = direction;
  }

  void changeSpeedBasedPlayer(Ship player) {
    if (parallax != null) {
      parallax!.baseVelocity = player.direction * 15;
    }
  }

  void resetGameplay() {
    parallax!.baseVelocity = Vector2(0, 0);
  }
}
