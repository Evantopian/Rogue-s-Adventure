import 'dart:math';

class Enemy {
  final String name;
  final int maxHp;
  final int currentHp;
  final int damage;
  final String imagePath;

  const Enemy({
    required this.name,
    required this.maxHp,
    required this.currentHp,
    required this.damage,
    required this.imagePath,
  });

  factory Enemy.scaled({
    required String name,
    required String imagePath,
    required int tier,
  }) {
    final Random random = Random();
    const int baseHp = 50;
    const int baseDamage = 10;
    final double hpScalingFactor = 1.2;
    final double damageScalingFactor = 1.1;

    final int scaledHp = (baseHp * pow(hpScalingFactor, tier)).toInt();
    final int scaledDamage = (baseDamage * pow(damageScalingFactor, tier)).toInt();

    return Enemy(
      name: name,
      maxHp: scaledHp + random.nextInt(scaledHp ~/ 2),
      currentHp: scaledHp,
      damage: scaledDamage + random.nextInt(scaledDamage ~/ 2),
      imagePath: imagePath,
    );
  }
}
