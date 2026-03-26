import 'package:bonfire/bonfire.dart';

class HeroSprite {
  static Future<SpriteAnimation> _idle(String prefix) async {
    return SpriteAnimation.spriteList([
      await Sprite.load('player/${prefix}0.png'),
    ], stepTime: 0.15);
  }

  static Future<SpriteAnimation> _run(String prefix) async {
    return SpriteAnimation.spriteList([
      await Sprite.load('player/${prefix}1.png'),
      await Sprite.load('player/${prefix}0.png'),
      await Sprite.load('player/${prefix}2.png'),
      await Sprite.load('player/${prefix}0.png'),
    ], stepTime: 0.15);
  }

  static SimpleDirectionAnimation playerAnimation() {
    return SimpleDirectionAnimation(
      idleRight: _idle('citizen_right'),
      runRight: _run('citizen_right'),

      idleLeft: _idle('citizen_left'),
      runLeft: _run('citizen_left'),

      idleDown: _idle('citizen'),
      runDown: _run('citizen'),

      idleUp: _idle('citizen_up'),
      runUp: _run('citizen_up'),
    );
  }
}
