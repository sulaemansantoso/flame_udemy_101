import 'dart:async';
// import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
// import 'package:flame/experimental.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class BlastParticle extends PositionComponent with HasGameRef {
  Vector2 parPosition;
  Vector2 parScale;

  late math.Random rnd;
  BlastParticle(this.parPosition, this.parScale)
      : super(position: parPosition, scale: parScale) {
    rnd = math.Random();
  }

  double ttl = 2.5;
  double timer = 0;

  @override
  FutureOr<void> onLoad() {
    var particleGenerator = ParticleSystemComponent(
      particle: Particle.generate(
        count: 30,
        generator: (i) {
          return MovingParticle(
              from: parPosition,
              to: parPosition +
                  Vector2(rnd.nextDouble() * 50 - 25,
                          rnd.nextDouble() * 50 - 25) *
                      2,
              child: CircleParticle(
                  radius: rnd.nextDouble() * 100 * parScale.x,
                  paint: Paint()
                    ..color = Color.fromARGB(rnd.nextInt(100) + 155, 255,
                        100 + rnd.nextInt(100), 0)));
        },
      ),
    );

    game.add(particleGenerator);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // timer += dt;
    // if (timer > ttl) {
    //   removeFromParent();
    // }
    super.update(dt);
  }
}
