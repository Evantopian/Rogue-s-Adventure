import "package:card_game/components/player.dart";
import "package:card_game/enums/target_types.dart";
import "package:card_game/components/entity.dart";
import "package:flame/components.dart";
import 'package:card_game/screens/flame_game_screen.dart';
import "package:flame/events.dart";
import 'package:flutter/painting.dart';

class Card extends PositionComponent with HasGameReference<RouterGame>, DragCallbacks{
  late String namePath;
  late double scaleFactor;
  late int cost;
  late double damage;
  late double shield;
  late TargetType targetType;

  Card(
      {required this.namePath,
      super.position, required super.size,
      required this.scaleFactor,
      required this.cost,
      required this.damage,
      required this.shield,
      required this.targetType});

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final cardImage = game.images.fromCache('Cards/$namePath.png');
    final scaledWidth = size.x * scaleFactor; // Scale width
    final scaledHeight = size.y * scaleFactor; // Scale height
    canvas.drawImageRect(
      cardImage,
      Rect.fromLTWH(
          0, 0, cardImage.width.toDouble(), cardImage.height.toDouble()),
      Rect.fromLTWH(position.x, position.y, scaledWidth, scaledHeight),
      Paint(),
    );
  }


  void playCard(List<Entity> targets, int selectedTargetIndex, Player player) {
    switch (targetType) {
      case TargetType.self:
        playSelf(player);
        break;
      case TargetType.single:
        if (selectedTargetIndex >= 0 && selectedTargetIndex < targets.length) {
          playSingle(targets[selectedTargetIndex]);
        } else {
          // Handle invalid target index
        }
        break;
      case TargetType.multi:
        playMulti(targets);
        break;
    }
  }

  void playSelf(Player player){
    player.onShield(shield);
    player.onHeal(damage);

  }
  void playSingle(Entity target){
    target.onTakeDamage(damage);
  }

  void playMulti(List<Entity> targets){}

}
