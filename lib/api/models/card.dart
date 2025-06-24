class Card {
  final int? cardId;
  final String name;
  final String type;
  final int damage;
  final int block;
  final int cost;
  final String target;
  final bool retain;
  final String description;
  final int deckId;

  Card({
    this.cardId,
    required this.name,
    required this.type,
    required this.damage,
    required this.block,
    required this.cost,
    required this.target,
    required this.retain,
    required this.description,
    required this.deckId,
  });

  Map<String, dynamic> toMap() {
    return {
      'card_id': cardId,
      'name': name,
      'type': type,
      'damage': damage,
      'block': block,
      'cost': cost,
      'target': target,
      'retain': retain,
      'description': description,
      'deck_id': deckId,
    };
  }

  static Card fromMap(Map<String, dynamic> map) {
    return Card(
      cardId: map['card_id'] as int?,
      name: map['name'] as String,
      type: map['type'] as String,
      damage: map['damage'] as int,
      block: map['block'] as int,
      cost: map['cost'] as int,
      target: map['target'] as String,
      retain: map['retain'] as bool,
      description: map['description'] as String,
      deckId: map['deck_id'] as int,
    );
  }
}