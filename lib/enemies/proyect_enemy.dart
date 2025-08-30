import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:star_wars/main.dart';

class ProyectailEnemy extends SpriteComponent with CollisionCallbacks {
  final double speed = 300;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("proyectail.png");
    size = Vector2(30, 50);
    add(RectangleHitbox());
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt; // ahora baja hacia el jugador

    if (position.y > GalaxyWars.screenSize.y + size.y) {
      removeFromParent();
    }
  }
}
