import 'package:postgres/postgres.dart';
import 'connect_db.dart';

Future<void> initializeDatabase(bool resetDatabase) async {
  final connection = await DbConnection.connectToDatabase();

  try {
    if (resetDatabase) {
      // Drop the existing players table
      await connection.execute('DROP TABLE IF EXISTS players');
    }

    // Create the players table
    await connection.execute('''
      CREATE TABLE IF NOT EXISTS players (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        experience INTEGER NOT NULL,
        score INTEGER NOT NULL
      )
    ''');

    print('Database initialized successfully');
  } catch (e) {
    print('Error initializing database: $e');
  } finally {
    await connection.close();
  }
}