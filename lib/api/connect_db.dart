import 'package:postgres/postgres.dart';

class DbConnection {
  static Future<Connection> connectToDatabase() async {
    // Establish the database connection
    final connection = await Connection.open(
      Endpoint(
        host: '127.0.0.1',
        database: 'card_game',
        username: 'postgres',
        password: 'superuserpassword',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    print("Postgres: SSL mode disabled.");
    return connection;
  }

  static Future<void> createPlayersTable(Connection connection) async {
    try {
      await connection.execute('''
        CREATE TABLE IF NOT EXISTS players (
          id TEXT PRIMARY KEY,
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          stage INT DEFAULT 1,
          experience INT DEFAULT 0
        )
      ''');
      print('Players table created successfully.');
    } catch (e) {
      print('Error creating players table: $e');
      rethrow;
    }
  }


  static Future<void> deletePlayersTable(Connection connection) async {
    try {
      await connection.execute('DROP TABLE IF EXISTS players');
      print('Players table deleted successfully.');
    } catch (e) {
      print('Error deleting players table: $e');
      rethrow;
    }
  }
}

void main() async {
  try {
    final connection = await DbConnection.connectToDatabase();
    print('Database connection successful!');
    
    // Create the players table
    await DbConnection.createPlayersTable(connection);
    
    // Uncomment the following line to delete the players table
    // await DbConnection.deletePlayersTable(connection);
    
    // Close the connection when done
    await connection.close();
    print('Database connection closed.');
  } catch (e) {
    print('Error connecting to the database: $e');
  }
}
