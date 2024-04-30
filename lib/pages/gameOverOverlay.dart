import 'package:flame_udemy_101/pages/myFlameGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameOverOverlay extends StatelessWidget {
  final MyFlameGame game;
  const GameOverOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: game.size.x * 0.3,
                height: game.size.y * 0.3,
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Game Over",
                          style: TextStyle(color: Colors.white, fontSize: 32)),
                      ElevatedButton(
                        onPressed: resetGameplay,
                        child: const Text("Try Again"),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void resetGameplay() {
    game.resetGame();
  }
}
