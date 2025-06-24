// abstract class entity
import 'package:flame/components.dart';
import 'package:card_game/screens/flame_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Entity extends PositionComponent with HasGameReference<RouterGame> {
  // max hp and current hp
  late double maxHealth;
  late double currentHealth;
  late double attack;
  late double shield;
  late double scaleFactor;

  String characterImagePath;

  Entity(
      {required Vector2 position,
      required Vector2 size,
      required this.maxHealth,
      required this.scaleFactor,
      this.characterImagePath = "player"})
      : currentHealth = maxHealth,
        super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final entityImage =
        game.images.fromCache('Characters/$characterImagePath.png');

    // Calculate scaled size
    final scaledWidth = size.x * scaleFactor; // Scale width
    final scaledHeight = size.y * scaleFactor; // Scale height

    // Draw scaled image
    canvas.drawImageRect(
      entityImage,
      Rect.fromLTWH(
          0, 0, entityImage.width.toDouble(), entityImage.height.toDouble()),
      Rect.fromLTWH(position.x, position.y, scaledWidth, scaledHeight),
      Paint(),
    );
    renderHealthBar(canvas);
  }

  void renderHealthBar(Canvas canvas) {
    // Calculate HP bar dimensions
    final double barWidth = size.x;
    final double barHeight = 10;
    final double healthPercentage = currentHealth / maxHealth;
    final double remainingWidth = barWidth * healthPercentage;

    // Calculate position for the health bar
    final double healthBarX = position.x + 15;
    final double healthBarY =
        position.y + size.y + 35; // Below the entity with some padding

    // Draw HP bar background
    Paint bgPaint = Paint()..color = Color.fromARGB(255, 255, 0, 0);
    canvas.drawRect(
        Rect.fromLTWH(healthBarX, healthBarY, barWidth, barHeight), bgPaint);

    // Draw HP bar foreground
    Paint fgPaint = Paint()..color = Color.fromARGB(255, 0, 255, 76);
    canvas.drawRect(
        Rect.fromLTWH(healthBarX, healthBarY, remainingWidth, barHeight),
        fgPaint);

    // Display current HP / Max HP text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$currentHealth / $maxHealth',
        style: TextStyle(color: Colors.white),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(
            healthBarX,
            healthBarY -
                textPainter.height -
                2)); // Above the health bar with some padding
  }

  void updateHealth(double newHealth) {
    currentHealth = newHealth.clamp(0, maxHealth);
    if (currentHealth <= 0) {
      // Handle character death
    }
  }

  void onTakeDamage(double damage) {
    if (shield > 0) {
      shield -= damage;
      if (shield < 0) {
        currentHealth += shield;
        shield = 0;
      }
    } else {
      currentHealth -= damage;
      if (currentHealth < 0) {
        currentHealth = 0;
        onDeath();
      }
    }
  }

  void onHeal(double heal) {
    currentHealth += heal;
    if (currentHealth > maxHealth) {
      currentHealth = maxHealth;
    }
  }

  void onShield(double shield) {
    this.shield += shield;
  }

  void onDeath() {
    print("Entity is dead");
  }
}
