import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:star_wars/main.dart';
import 'package:star_wars/players/proyectail.dart';

class Player extends SpriteComponent with KeyboardHandler {
  double speed = 200;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('player.png');
    anchor = Anchor.center;
    position = Vector2(
      GalaxyWars.screenSize.x / 2,
      GalaxyWars.screenSize.y - 70,
    );
    size = Vector2(100, 100);

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -200;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = 200;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      shoot();
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position += velocity * dt;
    position.clamp(
      Vector2(size.x / 2, position.y),
      Vector2(GalaxyWars.screenSize.x - size.x / 2, position.y),
    );
  }

  void shoot() {
    final proyectail = Proyectail()..position = Vector2(position.x, position.y);
    parent?.add(proyectail);
  }
}
