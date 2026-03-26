import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:tibia_mobile/core/constants.dart';
import 'package:tibia_mobile/interface/tibia_ui.dart'; // Importamos a interface!
import 'package:tibia_mobile/player/hero_player.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // <-- O Row é o que divide a tela na horizontal!
        children: [
          // O Expanded faz o jogo ocupar todo o espaço restante da tela
          Expanded(
            child: BonfireWidget(
              showCollisionArea: true,
              backgroundColor: const Color(0xFF222222),
              playerControllers: [
                Joystick(
                  directional: JoystickDirectional(
                    color: Colors.white,
                    isFixed: false,
                    size: 100,
                  ),
                ),
              ],
              player: HeroPlayer(
                position: Vector2(kTileSize * 4, kTileSize * 4),
              ),
              cameraConfig: CameraConfig(
                zoom: 2.0, // Nosso zoom travado
                moveOnlyMapArea: false,
              ),
              map: WorldMapByTiled(WorldMapReader.fromAsset('map/map.json')),
            ),
          ),

          // A nossa interface lateral!
          const TibiaUI(),
        ],
      ),
    );
  }
}
