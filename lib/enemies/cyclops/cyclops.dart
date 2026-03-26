import 'package:bonfire/bonfire.dart';

class CyclopsSprite {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    'npc/cyclops_idle.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    'npc/cyclops_run.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static SimpleDirectionAnimation cyclopsAnimation() =>
      SimpleDirectionAnimation(idleRight: idleRight, runRight: runRight);
}
