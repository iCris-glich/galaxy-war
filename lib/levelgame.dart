import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/enemies/enemy.dart';
import 'package:star_wars/enemies/enemy2.dart';
import 'package:star_wars/main.dart';
import 'package:star_wars/players/player.dart';

class Levelgame extends World {
  final Random random = Random();
  double bpm = 248;
  late double secondsPerBeat;
  double beatTimer = 0;
  int beatCount = 0;
  late TextComponent scoreText;
  late TextComponent lifeText;

  bool isGameOver = false; // <-- bandera para controlar Game Over

  @override
  FutureOr<void> onLoad() async {
    final player = Player();

    secondsPerBeat = 60 / bpm;

    add(await loadParallaxComponent());
    add(player);

    // Reproducir música en loop
    FlameAudio.bgm.play('deco27_monitoring.mp3', volume: 0.5);

    scoreText = TextComponent(
      text: 'Score: ${GalaxyWars.score}',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    lifeText = TextComponent(
      text: 'Life: ${GalaxyWars.life}',
      position: Vector2(10, 40),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    addAll([scoreText, lifeText]);

    return super.onLoad();
  }

  Future<ParallaxComponent> loadParallaxComponent() async {
    return ParallaxComponent.load(
      [ParallaxImageData('bg.jpeg')],
      repeat: ImageRepeat.repeatY,
      baseVelocity: Vector2(0, -100),
      velocityMultiplierDelta: Vector2(1.0, 1.5),
      size: GalaxyWars.screenSize,
    );
  }

  void spawnEnemiesFromBeat() {
    if (isGameOver) return; // No spawnear si terminó el juego

    // Enemy 1 cada 4 beats
    if (beatCount % 4 == 0) {
      final x = random.nextDouble() * (GalaxyWars.screenSize.x - 70);
      add(Enemy(position: Vector2(x, -70)));
    }

    // Enemy 2 cada 12 beats
    if (beatCount % 12 == 1) {
      final x2 = random.nextDouble() * (GalaxyWars.screenSize.x - 70);
      add(Enemy2(position: Vector2(x2, -70)));
    }

    // Extra Enemy2 si score alto
    if (GalaxyWars.score > 300 && beatCount % 4 == 0) {
      final x3 = random.nextDouble() * (GalaxyWars.screenSize.x - 70);
      add(Enemy2(position: Vector2(x3, -70)));
    }

    beatCount++;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return; // no actualizar nada más

    beatTimer += dt;

    if (beatTimer >= secondsPerBeat) {
      spawnEnemiesFromBeat();
      beatTimer -= secondsPerBeat;
    }

    if (GalaxyWars.life <= 0) {
      gameOver();
    }

    scoreText.text = 'Score: ${GalaxyWars.score}';
    lifeText.text = 'Life: ${GalaxyWars.life}';
  }

  void gameOver() {
    isGameOver = true;
    FlameAudio.bgm.stop();

    // Mostrar texto de Game Over
    add(
      TextComponent(
        text: 'GAME OVER',
        position: Vector2(
          GalaxyWars.screenSize.x / 2,
          GalaxyWars.screenSize.y / 2,
        ),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.red,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
