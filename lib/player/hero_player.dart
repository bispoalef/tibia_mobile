import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:tibia_mobile/core/constants.dart';
import 'package:tibia_mobile/player/hero_sprite.dart';

class HeroPlayer extends SimplePlayer with BlockMovementCollision, UseLifeBar {
  Vector2? _targetPosition;
  JoystickMoveDirectional _joystickDirection = JoystickMoveDirectional.IDLE;
  JoystickMoveDirectional _movingDirection = JoystickMoveDirectional.IDLE;

  double baseSpeed = 50.0;
  double speedBonus = 0.0;

  HeroPlayer({required Vector2 position})
    : super(
        position: position,
        size: Vector2(kTileSize, kTileSize),
        animation: HeroSprite.playerAnimation(),
        speed: 50.0,
      );

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
        size: Vector2(kTileSize - 4, kTileSize - 4),
        position: Vector2(2, 2),
      ),
    );
    return super.onLoad();
  }

  void applySpeedChange({required double bonus}) {
    speedBonus = bonus;
    speed = baseSpeed + speedBonus;
  }

  @override
  void onBlockedMovement(PositionComponent other, CollisionData collisionData) {
    if (_targetPosition != null) {
      _targetPosition = null;

      stopMove();

      position = Vector2(
        (position.x / kTileSize).round() * kTileSize,
        (position.y / kTileSize).round() * kTileSize,
      );
    }
    super.onBlockedMovement(other, collisionData);
  }

  @override
  void onJoystickChangeDirectional(JoystickDirectionalEvent event) {
    _joystickDirection = event.directional;
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      _attack();
    }
    super.onJoystickAction(event);
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
  void update(double dt) {
    if (_targetPosition != null) {
      _continueMovingToTile(dt);
    } else {
      _checkNewMove();
    }

    if (_joystickDirection != JoystickMoveDirectional.IDLE) {
      if (_targetPosition == null) {
        _forceAnimationWhileBlocked();
      }
    } else if (_targetPosition == null) {
      stopMove();
    }

    super.update(dt);
  }

  void _checkNewMove() {
    if (_joystickDirection != JoystickMoveDirectional.IDLE) {
      _movingDirection = _joystickDirection;
      _targetPosition = _calculateTargetTile(_joystickDirection);
    } else {
      if (_targetPosition == null) {
        stopMove();
      }
    }
  }

  Vector2 _calculateTargetTile(JoystickMoveDirectional dir) {
    Vector2 target = position.clone();
    switch (dir) {
      case JoystickMoveDirectional.MOVE_UP:
        target.y -= kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_DOWN:
        target.y += kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_LEFT:
        target.x -= kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_RIGHT:
        target.x += kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_UP_LEFT:
        target.y -= kTileSize;
        target.x -= kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_UP_RIGHT:
        target.y -= kTileSize;
        target.x += kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_DOWN_LEFT:
        target.y += kTileSize;
        target.x -= kTileSize;
        break;
      case JoystickMoveDirectional.MOVE_DOWN_RIGHT:
        target.y += kTileSize;
        target.x += kTileSize;
        break;
      default:
        break;
    }
    return target;
  }

  void _continueMovingToTile(double dt) {
    double stepDistance = speed * dt;
    double distanceToTarget = position.distanceTo(_targetPosition!);

    if (distanceToTarget <= stepDistance) {
      position = _targetPosition!;
      _targetPosition = null;

      if (_joystickDirection == JoystickMoveDirectional.IDLE) {
        stopMove();
      }
    } else {
      _movePlayerByDirection(_movingDirection);
    }
  }

  void _movePlayerByDirection(JoystickMoveDirectional dir) {
    switch (dir) {
      case JoystickMoveDirectional.MOVE_UP:
        moveUp(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_DOWN:
        moveDown(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_LEFT:
        moveLeft(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_RIGHT:
        moveRight(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_UP_LEFT:
        moveUpLeft(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_UP_RIGHT:
        moveUpRight(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_DOWN_LEFT:
        moveDownLeft(speed: speed);
        break;
      case JoystickMoveDirectional.MOVE_DOWN_RIGHT:
        moveDownRight(speed: speed);
        break;
      default:
        break;
    }
  }

  void _forceAnimationWhileBlocked() {
    switch (_joystickDirection) {
      case JoystickMoveDirectional.MOVE_UP:
        animation?.play(SimpleAnimationEnum.runUp);
        break;
      case JoystickMoveDirectional.MOVE_DOWN:
        animation?.play(SimpleAnimationEnum.runDown);
        break;
      case JoystickMoveDirectional.MOVE_LEFT:
        animation?.play(SimpleAnimationEnum.runLeft);
        break;
      case JoystickMoveDirectional.MOVE_RIGHT:
        animation?.play(SimpleAnimationEnum.runRight);
        break;
      case JoystickMoveDirectional.MOVE_UP_LEFT:
        animation?.play(SimpleAnimationEnum.runUpLeft);
        break;
      case JoystickMoveDirectional.MOVE_UP_RIGHT:
        animation?.play(SimpleAnimationEnum.runUpRight);
        break;
      case JoystickMoveDirectional.MOVE_DOWN_LEFT:
        animation?.play(SimpleAnimationEnum.runDownLeft);
        break;
      case JoystickMoveDirectional.MOVE_DOWN_RIGHT:
        animation?.play(SimpleAnimationEnum.runDownRight);
        break;
      default:
        break;
    }
  }

  void _attack() {
    simpleAttackMelee(damage: 5, size: Vector2(kTileSize, kTileSize));
  }
}
