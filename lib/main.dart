import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/levelgame.dart';

void main() {
  runApp(GameWidget(game: GalaxyWars()));
}

class GalaxyWars extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  static Vector2 screenSize = Vector2(400, 600);
  late CameraComponent cameraComponent;
  late Levelgame levelgame;

  @override
  FutureOr<void> onLoad() {
    levelgame = Levelgame();
    cameraComponent = CameraComponent.withFixedResolution(
      width: screenSize.x,
      height: screenSize.y,
      world: levelgame,
    );

    cameraComponent.viewfinder.anchor = Anchor.topLeft;

    addAll([cameraComponent, levelgame]);
    return super.onLoad();
  }
}
