import 'package:bonfire/bonfire.dart';

class TrollSprite {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    'npc/troll_idle.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    'npc/troll_run.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static SimpleDirectionAnimation trollAnimation() =>
      SimpleDirectionAnimation(idleRight: idleRight, runRight: runRight);
}
