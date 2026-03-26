import 'package:bonfire/bonfire.dart';

class HeroSprite {
  // Parado: Pega o arquivo de final '0.png'
  static Future<SpriteAnimation> _idle(String prefix) async {
    return SpriteAnimation.spriteList([
      await Sprite.load('player/${prefix}0.png'),
    ], stepTime: 0.15);
  }

  // Andando: Ciclo Tibia (0 -> 1 -> 0 -> 2)
  static Future<SpriteAnimation> _run(String prefix) async {
    return SpriteAnimation.spriteList([
      await Sprite.load('player/${prefix}1.png'), // Passo 1
      await Sprite.load('player/${prefix}0.png'), // Centro
      await Sprite.load('player/${prefix}2.png'), // Passo 2
      await Sprite.load('player/${prefix}0.png'), // Centro
    ], stepTime: 0.15);
  }

  static SimpleDirectionAnimation playerAnimation() {
    return SimpleDirectionAnimation(
      // --- DIREITA (Right) ---
      // AQUI ESTÁ A CORREÇÃO: Passando 'null', o Bonfire entende que
      // deve espelhar o '_left' automaticamente!
      idleRight: _idle('citizen_right'),
      runRight: _run('citizen_right'),

      // --- ESQUERDA (Left) ---
      idleLeft: _idle('citizen_left'),
      runLeft: _run('citizen_left'),

      // --- FRENTE (Down) ---
      idleDown: _idle('citizen'),
      runDown: _run('citizen'),

      // --- COSTAS (Up) ---
      idleUp: _idle('citizen_up'),
      runUp: _run('citizen_up'),
    );
  }
}
