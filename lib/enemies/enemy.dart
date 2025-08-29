import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:star_wars/main.dart';
import 'package:star_wars/players/proyectail.dart';

class Enemy extends SpriteComponent with CollisionCallbacks {
  Enemy({super.position});

  final double speed = 250;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("enemy.png");

    size = Vector2(70, 70);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position.y += speed * dt;

    if (position.y > GalaxyWars.screenSize.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Proyectail) {
      removeFromParent();
      other.removeFromParent();
    }
  }
}
