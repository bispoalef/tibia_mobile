import 'package:bonfire/bonfire.dart';

class RatSprite {
  // O caminho base até o prefixo 'rat_'
  static String path = 'enemies/rat/rat';

  static Future<SimpleDirectionAnimation> get animation async {
    return SimpleDirectionAnimation(
      // IDLE (Frame 1 é o seu frame 'parado/centro' conforme o script)
      idleUp: _getAnimation('up', [1]),
      idleRight: _getAnimation('right', [1]),
      idleDown: _getAnimation('down', [1]),
      idleLeft: _getAnimation('left', [1]),

      // RUN (Ciclo: Passo 1 -> Centro -> Passo 2 -> Centro)
      runUp: _getAnimation('up', [0, 1, 2, 1]),
      runRight: _getAnimation('right', [0, 1, 2, 1]),
      runDown: _getAnimation('down', [0, 1, 2, 1]),
      runLeft: _getAnimation('left', [0, 1, 2, 1]),
    );
  }

  static Future<SpriteAnimation> _getAnimation(
    String direction, // Agora passamos 'up', 'down', etc.
    List<int> frames,
  ) async {
    List<Sprite> sprites = [];
    for (int f in frames) {
      // Monta o nome: rat_down0.png, rat_right1.png, etc.
      // O path já termina em 'rat', então adicionamos o '_' e a direção
      sprites.add(await Sprite.load('${path}_$direction$f.png'));
    }
    return SpriteAnimation.spriteList(sprites, stepTime: 0.15);
  }
}
