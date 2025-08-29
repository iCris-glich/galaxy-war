import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Proyectail extends SpriteComponent with CollisionCallbacks {
  final double speed = 200;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("proyectail.png");
    size = Vector2(30, 50);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= speed * dt;

    if (position.y < -size.y) {
      removeFromParent();
    }
  }
}
