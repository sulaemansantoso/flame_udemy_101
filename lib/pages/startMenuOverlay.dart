import 'package:flame_udemy_101/pages/myFlameGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartMenuOverlay extends StatelessWidget {
  final MyFlameGame game;
  const StartMenuOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Material(
      color: const Color.fromARGB(43, 75, 75, 75),
      child: Center(
        child: SizedBox(
          width: game.size.x * 0.5,
          height: game.size.y * 0.5,
          child: Card(
            color: const Color.fromARGB(240, 0, 0, 0),
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Asteroid Destroyer",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Image(
                    image:
                        AssetImage("assets/images/Ships/spaceShips_001.png")),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FloatingActionButton(
                      onPressed: startGame,
                      child: const Text("Start Game"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startGame() {
    game.resumeEngine();
    game.overlays.remove("startmenu");
  }
}
