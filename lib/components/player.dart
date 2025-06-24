import "package:card_game/api/models/player.dart";
import "package:card_game/components/entity.dart";
import "package:card_game/components/card.dart";
import "package:flame/components.dart";
import 'package:card_game/screens/flame_game_screen.dart';


class Player extends Entity {

  
  late String name;
  late int currentStage;
  late List<Card> deck;
  late List<Card> hand;
  late List<Card> discardPile;
  late List<Card> drawPile;

  Player({required super.position, required super.size, required super.maxHealth, required super.scaleFactor});


  
  
  @override
  void onDeath(){
    print("Player is dead");
  }
}