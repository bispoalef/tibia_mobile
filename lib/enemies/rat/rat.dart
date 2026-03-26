import 'package:bonfire/bonfire.dart';

class RatSprite {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    'npc/rat_idle.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    'npc/rat_run.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static SimpleDirectionAnimation ratAnimation() =>
      SimpleDirectionAnimation(idleRight: idleRight, runRight: runRight);
}
