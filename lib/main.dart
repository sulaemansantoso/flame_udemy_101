import 'package:flame/game.dart';
import 'package:flame_udemy_101/pages/gameOverOverlay.dart';
import 'package:flame_udemy_101/pages/myFlameGame.dart';
import 'package:flame_udemy_101/pages/startMenuOverlay.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyGameWidget());
}

class MyGameWidget extends StatelessWidget {
  const MyGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GameWidget(
        game: MyFlameGame(),
        overlayBuilderMap: {
          'gameover': (context, MyFlameGame game) {
            return GameOverOverlay(game);
          },
          'startmenu': (context, MyFlameGame game) {
            return StartMenuOverlay(game);
          },
        },
        //adding initial overlays
        initialActiveOverlays: const ["startmenu"],
      ),
    );
  }
}
