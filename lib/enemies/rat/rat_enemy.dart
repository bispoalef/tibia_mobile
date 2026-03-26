import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:tibia_mobile/core/constants.dart';
import 'package:tibia_mobile/enemies/rat/rat_scrite.dart';

class RatEnemy extends SimpleEnemy with BlockMovementCollision, UseLifeBar {
  JoystickMoveDirectional _movingDirection = JoystickMoveDirectional.IDLE;
  Vector2? _targetPosition;
  double _idleTimer = 0;

  RatEnemy({required super.position})
    : super(size: Vector2(kTileSize, kTileSize), speed: 50, life: 20) {
    RatSprite.animation.then((anim) => animation = anim);
  }

  @override
  Future<void> onLoad() {
    setupLifeBar(
      size: Vector2(kTileSize, 4),
      barLifeDrawPosition: BarLifeDrawPosition.top,
      borderRadius: BorderRadius.zero,
      borderWidth: 1.5,
      borderColor: Colors.black,
      showLifeText: false,
      colors: [Colors.red, Colors.yellow, Colors.green],
    );

    add(
      RectangleHitbox(
        size: Vector2(kTileSize - 8, kTileSize - 8),
        position: Vector2(4, 4),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (isDead) return;

    seePlayer(
      radiusVision: kTileSize * 4,
      observed: (player) {
        seeAndMoveToPlayer(
          closePlayer: (player) => _executeAttack(),
          radiusVision: kTileSize * 4,
          margin: 4,
        );
      },
      notObserved: () => _runTibiaStyleRandomMove(dt),
    );

    super.update(dt);
  }

  void _runTibiaStyleRandomMove(double dt) {
    if (_targetPosition != null) {
      double distance = position.distanceTo(_targetPosition!);
      if (distance <= speed * dt + 1) {
        position = _targetPosition!.clone();
        _targetPosition = null;
        stopMove();
      } else {
        _moveByDirection(_movingDirection);
      }
    } else {
      _idleTimer += dt;
      if (_idleTimer >= 2.0) {
        _idleTimer = 0;
        _startRandomStep();
      }
    }
  }

  void _startRandomStep() {
    final dir = Random().nextInt(5);
    if (dir == 0) return;

    _movingDirection = [
      JoystickMoveDirectional.IDLE,
      JoystickMoveDirectional.MOVE_UP,
      JoystickMoveDirectional.MOVE_RIGHT,
      JoystickMoveDirectional.MOVE_DOWN,
      JoystickMoveDirectional.MOVE_LEFT,
    ][dir];

    _targetPosition = position.clone();
    if (_movingDirection == JoystickMoveDirectional.MOVE_UP)
      _targetPosition!.y -= kTileSize;
    if (_movingDirection == JoystickMoveDirectional.MOVE_DOWN)
      _targetPosition!.y += kTileSize;
    if (_movingDirection == JoystickMoveDirectional.MOVE_LEFT)
      _targetPosition!.x -= kTileSize;
    if (_movingDirection == JoystickMoveDirectional.MOVE_RIGHT)
      _targetPosition!.x += kTileSize;
  }

  void _moveByDirection(JoystickMoveDirectional dir) {
    if (dir == JoystickMoveDirectional.MOVE_UP) moveUp(speed: speed);
    if (dir == JoystickMoveDirectional.MOVE_DOWN) moveDown(speed: speed);
    if (dir == JoystickMoveDirectional.MOVE_LEFT) moveLeft(speed: speed);
    if (dir == JoystickMoveDirectional.MOVE_RIGHT) moveRight(speed: speed);
  }

  void _executeAttack() {
    simpleAttackMelee(
      damage: 2,
      size: Vector2(kTileSize, kTileSize),
      interval: 1000,
    );
  }

  @override
  void onReceiveDamage(
    AttackOriginEnum attacker,
    double damage,
    dynamic identify,
  ) {
    showDamage(
      damage,
      config: const TextStyle(
        color: Colors.red,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    super.onReceiveDamage(attacker, damage, identify);
  }

  @override
  void onBlockedMovement(PositionComponent other, CollisionData collisionData) {
    _targetPosition = null;
    stopMove();
    super.onBlockedMovement(other, collisionData);
  }
}
