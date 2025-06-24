import 'deck.dart';

class Player {
  final int? playerId;
  final String name;
  final int hp;
  final int energy;
  final List<Deck> decks;
  final int level;
  final int exp;

  Player({
    this.playerId,
    required this.name,
    required this.hp,
    required this.energy,
    required this.decks,
    required this.level,
    required this.exp,
  });

  Map<String, dynamic> toMap() {
    return {
      'player_id': playerId,
      'name': name,
      'hp': hp,
      'energy': energy,
      'decks': decks.map((deck) => deck.toMap()).toList(),
      'level': level,
      'exp': exp,
    };
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
      playerId: map['player_id'] as int?,
      name: map['name'] as String,
      hp: map['hp'] as int,
      energy: map['energy'] as int,
      decks: (map['decks'] as List<dynamic>).map((deckMap) => Deck.fromMap(deckMap)).toList(),
      level: map['level'] as int,
      exp: map['exp'] as int,
    );
  }
}
