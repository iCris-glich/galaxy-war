import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/enemies/enemy.dart';
import 'package:star_wars/main.dart';
import 'package:star_wars/players/player.dart';

class Levelgame extends World {
  Random random = Random();
  double enemySpawTimer = 0;

  @override
  FutureOr<void> onLoad() async {
    Player player = Player();
    add(await loadParallaxComponent());
    add(await player);
    return super.onLoad();
  }

  Future<ParallaxComponent> loadParallaxComponent() async {
    return ParallaxComponent.load(
      [ParallaxImageData('bg.jpeg')],
      repeat: ImageRepeat.repeatY,
      baseVelocity: Vector2(0, -20),
      velocityMultiplierDelta: Vector2(1.0, 1.5),
      size: GalaxyWars.screenSize,
    );
  }

  void spawnEnemies() {
    final x = random.nextDouble() * (GalaxyWars.screenSize.x - 70);
    add(Enemy(position: Vector2(x, -70)));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    enemySpawTimer += dt;

    if (enemySpawTimer > 2) {
      spawnEnemies();
      enemySpawTimer = 0;
    }
  }
}
