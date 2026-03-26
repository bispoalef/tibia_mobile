import 'package:bonfire/bonfire.dart';
import 'package:tibia_mobile/core/constants.dart';
import 'package:tibia_mobile/player/hero_sprite.dart';

class HeroPlayer extends SimplePlayer with BlockMovementCollision {
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
      // Removi o stopMove() daqui!
      // Ao não parar o movimento, o Bonfire continua executando a última animação de 'run'.

      // Snap para o grid para evitar bugs de colisão
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
  void update(double dt) {
    if (_targetPosition != null) {
      _continueMovingToTile(dt);
    } else {
      _checkNewMove();
    }

    // NOVIDADE: Se o joystick estiver pressionado mas não tivermos alvo (bloqueado),
    // forçamos a animação de "run" correspondente à direção do joystick.
    if (_targetPosition == null &&
        _joystickDirection != JoystickMoveDirectional.IDLE) {
      _forceAnimationWhileBlocked();
    }

    super.update(dt);
  }

  void _checkNewMove() {
    if (_joystickDirection != JoystickMoveDirectional.IDLE) {
      _movingDirection = _joystickDirection;
      _targetPosition = _calculateTargetTile(_joystickDirection);
    } else {
      stopMove();
    }
  }

  Vector2 _calculateTargetTile(JoystickMoveDirectional dir) {
    Vector2 target = position.clone();

    if (dir == JoystickMoveDirectional.MOVE_UP) {
      target.y -= kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_DOWN) {
      target.y += kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_LEFT) {
      target.x -= kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_RIGHT) {
      target.x += kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_UP_LEFT) {
      target.y -= kTileSize;
      target.x -= kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_UP_RIGHT) {
      target.y -= kTileSize;
      target.x += kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_DOWN_LEFT) {
      target.y += kTileSize;
      target.x -= kTileSize;
    } else if (dir == JoystickMoveDirectional.MOVE_DOWN_RIGHT) {
      target.y += kTileSize;
      target.x += kTileSize;
    }
    return target;
  }

  void _continueMovingToTile(double dt) {
    double stepDistance = speed * dt;
    double distanceToTarget = position.distanceTo(_targetPosition!);

    if (distanceToTarget <= stepDistance) {
      position = _targetPosition!;
      _targetPosition = null;
      stopMove();
    } else {
      _movePlayerByDirection(_movingDirection);
    }
  }

  void _movePlayerByDirection(JoystickMoveDirectional dir) {
    // Usa os métodos nativos do Bonfire para aplicar velocidade
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
    // Esse método garante que o boneco continue "andando no lugar" contra a parede
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
}
