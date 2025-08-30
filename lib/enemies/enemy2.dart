import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:star_wars/enemies/proyect_enemy.dart';
import 'package:star_wars/main.dart';
import 'package:star_wars/players/proyectail.dart';

class Enemy2 extends SpriteComponent with CollisionCallbacks {
  Enemy2({super.position});
  final double speed = 125;
  double shootTimer = 0;
  final double shootInterval = 1.0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("enemy2.jpg");

    size = Vector2(70, 70);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;

    shootTimer += dt;
    if (shootTimer >= shootInterval) {
      shoot();
      shootTimer = 0;
    }

    if (position.y > GalaxyWars.screenSize.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    int scoreEnemy1 = 15;
    if (other is Proyectail) {
      removeFromParent();
      other.removeFromParent();
      GalaxyWars.score += scoreEnemy1;
      print("Puntos: ${GalaxyWars.score}");
    }
  }

  void shoot() {
    final proyectail = ProyectailEnemy()
      ..position = Vector2(position.x + size.x / 2 - 5, position.y + size.y);
    parent?.add(proyectail);
  }
}
