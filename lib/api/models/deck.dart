import 'card.dart';

class Deck {
  final int? deckId;
  final int count; // maybe different tier decks, different max cards.
  final int cardId;
  final List<Card>? cards;

  Deck({
    this.deckId,
    required this.count,
    required this.cardId,
    this.cards,
  });

  Map<String, dynamic> toMap() {
    return {
      'deck_id': deckId,
      'count': count,
      'card_id': cardId,
    };
  }

  static Deck fromMap(Map<String, dynamic> map) {
    return Deck(
      deckId: map['deck_id'] as int?,
      count: map['count'] as int,
      cardId: map['card_id'] as int,
    );
  }
}