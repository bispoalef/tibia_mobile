import 'package:bonfire/bonfire.dart';

class RatSprite {
  static String path = 'enemies/rat/rat';

  static Future<SimpleDirectionAnimation> get animation async {
    return SimpleDirectionAnimation(
      idleUp: _getAnimation('up', [1]),
      idleRight: _getAnimation('right', [1]),
      idleDown: _getAnimation('down', [1]),
      idleLeft: _getAnimation('left', [1]),

      runUp: _getAnimation('up', [0, 1, 2, 1]),
      runRight: _getAnimation('right', [0, 1, 2, 1]),
      runDown: _getAnimation('down', [0, 1, 2, 1]),
      runLeft: _getAnimation('left', [0, 1, 2, 1]),
    );
  }

  static Future<SpriteAnimation> _getAnimation(
    String direction,
    List<int> frames,
  ) async {
    List<Sprite> sprites = [];
    for (int f in frames) {
      sprites.add(await Sprite.load('${path}_$direction$f.png'));
    }
    return SpriteAnimation.spriteList(sprites, stepTime: 0.15);
  }
}
