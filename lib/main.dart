import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/levelgame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlameAudio.audioCache.loadAll(['deco27_monitoring.mp3']);

  runApp(GameWidget(game: GalaxyWars()));
}

class GalaxyWars extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  static Vector2 screenSize = Vector2(400, 600);
  late CameraComponent cameraComponent;
  late Levelgame levelgame;
  static int score = 0;
  static int life = 8;

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

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
