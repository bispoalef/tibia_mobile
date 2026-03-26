import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:tibia_mobile/core/constants.dart';
import 'enemies/troll/troll_enemy.dart';
import 'enemies/rat/rat_enemy.dart';
import 'enemies/cyclops/cyclops_enemy.dart';
import 'interface/tibia_ui.dart';
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
                  directional: JoystickDirectional(),
                  actions: [
                    JoystickAction(
                      actionId: 1, // ID do botão de ataque
                      margin: const EdgeInsets.all(40),
                      color: Colors.red.withOpacity(0.5),
                    ),
                  ],
                ),
              ],
              player: HeroPlayer(
                position: Vector2(kTileSize * 4, kTileSize * 4),
              ),
              cameraConfig: CameraConfig(
                zoom: 2.0, // Nosso zoom travado
                moveOnlyMapArea: false,
              ),
              map: WorldMapByTiled(
                WorldMapReader.fromAsset('map/map.json'),
                objectsBuilder: {
                  // Certifique-se de que o nome no Tiled seja 'rat'
                  'rat': (properties) =>
                      RatEnemy(position: properties.position),
                  'cyclops': (properties) =>
                      CyclopsEnemy(position: properties.position),
                  'troll': (properties) =>
                      TrollEnemy(position: properties.position),
                },
              ),
            ),
          ),

          // A nossa interface lateral!
          const TibiaUI(),
        ],
      ),
    );
  }
}
