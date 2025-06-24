import 'enemy.dart';

class Level {
  final String name;
  final List<Enemy> enemies;

  const Level({
    required this.name,
    required this.enemies,
  });
}

class Stage {
  final String name;
  final List<Level> levels;

  const Stage({
    required this.name,
    required this.levels,
  });
}

class Stages {
  final List<Stage> stages;

  const Stages({
    required this.stages,
  });

  static Level createLevel(String name, List<Map<String, dynamic>> enemiesData) {
    final List<Enemy> enemies = enemiesData
        .map((enemyData) => Enemy.scaled(
              name: enemyData['name'],
              imagePath: enemyData['imagePath'],
              tier: enemyData['tier'],
            ))
        .toList();
    return Level(name: name, enemies: enemies);
  }

  static Stage createStage(String name, List<List<Map<String, dynamic>>> levelsData) {
    final List<Level> levels = levelsData
        .map((levelData) => createLevel(
              levelData[0]['name'],
              levelData[1]['enemies'],
            ))
        .toList();
    return Stage(name: name, levels: levels);
  }
}
