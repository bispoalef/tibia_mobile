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
        children: [
          Expanded(
            child: BonfireWidget(
              showCollisionArea: true,
              backgroundColor: const Color(0xFF222222),
              playerControllers: [
                Joystick(
                  directional: JoystickDirectional(),
                  actions: [
                    JoystickAction(
                      actionId: 1,
                      margin: const EdgeInsets.all(40),
                      color: Colors.red.withOpacity(0.5),
                    ),
                  ],
                ),
              ],
              player: HeroPlayer(
                position: Vector2(kTileSize * 4, kTileSize * 4),
              ),
              cameraConfig: CameraConfig(zoom: 2.0, moveOnlyMapArea: false),
              map: WorldMapByTiled(
                WorldMapReader.fromAsset('map/map.json'),
                objectsBuilder: {
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

          const TibiaUI(),
        ],
      ),
    );
  }
}
