import 'dart:ui' as ui;
import 'package:bonfire/bonfire.dart';

class TrollSprite {
  static String path = 'enemies/troll/troll';

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
      final sprite = await _composeFrame(direction, f);
      sprites.add(sprite);
    }

    return SpriteAnimation.spriteList(sprites, stepTime: 0.15);
  }

  static Future<Sprite> _composeFrame(String direction, int frame) async {
    final img1 = await Flame.images.load('${path}_$direction${frame}_1.png');
    final img2 = await Flame.images.load('${path}_$direction${frame}_2.png');
    final img3 = await Flame.images.load('${path}_$direction${frame}_3.png');
    final img4 = await Flame.images.load('${path}_$direction${frame}_4.png');

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    canvas.drawImage(img1, ui.Offset(0, 0), ui.Paint());
    canvas.drawImage(img2, ui.Offset(32, 0), ui.Paint());
    canvas.drawImage(img3, ui.Offset(0, 32), ui.Paint());
    canvas.drawImage(img4, ui.Offset(32, 32), ui.Paint());

    final picture = recorder.endRecording();
    final combinedImage = await picture.toImage(64, 64);

    return Sprite(combinedImage);
  }
}
