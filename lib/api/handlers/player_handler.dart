import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/player.dart';
import '../connect_db.dart'; 

class PlayerHandler {
  Router get router {
    final router = Router();

    // Define routes
    router.get('/players', _getAllPlayers);
    router.post('/players', _createPlayer);
    router.get('/players/<id>', _getPlayerById);
    router.put('/players/<id>', _updatePlayer); 
    router.delete('/players/<id>', _deletePlayer);

    return router;
  }

  Future<Response> _getAllPlayers(Request request) async {
      try {
        final conn = await DbConnection.connectToDatabase();

        // Build the SQL query with optional filtering and sorting
        var query = 'SELECT * FROM players';
        var params = <String, dynamic>{};

        // Filter by username (optional)
        var username = request.url.queryParameters['username'];
        if (username != null) {
          query += ' WHERE username = @username';
          params['username'] = username;
        }

        // Sort by stage (optional)
        var sortByStage = request.url.queryParameters['sortByStage'];
        if (sortByStage != null) {
          query += ' ORDER BY stage ${sortByStage.toLowerCase() == 'asc' ? 'ASC' : 'DESC'}';
        }

        final results = await conn.execute(Sql.named(query), parameters: params);
        await conn.close();

        final players = results.map((row) => Player.fromJson(row.toColumnMap())).toList();
        return Response.ok(json.encode(players.map((player) => player.toJson()).toList()), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        print('Error retrieving players: $e');
        return Response.internalServerError();
      }
    }

  /* 
    For testing:
    Example:
    curl -X POST http://localhost:8080/players -H "Content-Type: application/json" -d '{"id": "testplayer123", "username": "jerry", "password": "pass123", "stage": 4, "experience": 500}'
  */
  Future<Response> _createPlayer(Request request) async {
    try {
      var body = await request.readAsString();
      var jsonBody = json.decode(body);
      var player = Player.fromJson(jsonBody);

      final conn = await DbConnection.connectToDatabase();
      await conn.execute(
        Sql.named('''
          INSERT INTO players (id, username, password, stage, experience)
          VALUES (@id, @username, @password, @stage, @experience)
        '''),
        parameters: {
          'id': player.id, // Use the custom ID from Firebase Auth in the future
          'username': player.username,
          'password': player.password,
          'stage': player.stage,
          'experience': player.experience,
        },
      );
      await conn.close();

      return Response.ok(json.encode(player.toJson()), headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print('Error creating player: $e');
      return Response.internalServerError();
    }
  }

Future<Response> _updatePlayer(Request request) async {
  try {
    var playerId = request.url.pathSegments.last;
    var body = await request.readAsString();
    var jsonBody = json.decode(body);
    
    // Initialize variables to hold updated values
    var updatedUsername = jsonBody['username'];
    var updatedPassword = jsonBody['password'];
    var updatedStage = jsonBody['stage'];
    var updatedExperience = jsonBody['experience'];

    // Update the player in the database
    final conn = await DbConnection.connectToDatabase();
    await conn.execute(
      Sql.named('''
        UPDATE players
        SET username = @username, password = @password, stage = @stage, experience = @experience
        WHERE id = @id
      '''),
      parameters: {
        'id': playerId,
        'username': updatedUsername,
        'password': updatedPassword,
        'stage': updatedStage,
        'experience': updatedExperience,
      },
    );

    // Retrieve the updated player from the database
    final results = await conn.execute(
      Sql.named('SELECT * FROM players WHERE id = @id'),
      parameters: {'id': playerId},
    );
    await conn.close();

    if (results.isNotEmpty) {
      var updatedPlayer = Player.fromJson(results.first.toColumnMap());
      return Response.ok(json.encode(updatedPlayer.toJson()), headers: {'Content-Type': 'application/json'});
    } else {
      return Response.notFound('Player not found');
    }
  } catch (e, s) {
    print('Error updating player: $e \nStack Trace $s');
    return Response.internalServerError();
  }
}

  

  Future<Response> _getPlayerById(Request request) async {
    try {
      var playerId = request.url.pathSegments.last;

      final conn = await DbConnection.connectToDatabase();
      final results = await conn.execute(Sql.named('SELECT * FROM players WHERE id = @id'), parameters: {'id': playerId});
      await conn.close();

      if (results.isNotEmpty) {
        var player = Player.fromJson(results.first.toColumnMap());
        return Response.ok(json.encode(player.toJson()), headers: {'Content-Type': 'application/json'});
      } else {
        return Response.notFound('Player not found');
      }
    } catch (e) {
      print('Error retrieving player: $e');
      return Response.internalServerError();
    }
  }

  Future<Response> _deletePlayer(Request request) async {
    try {
      var playerId = request.url.pathSegments.last;

      final conn = await DbConnection.connectToDatabase();
      final result = await conn.execute(Sql.named('DELETE FROM players WHERE id = @id'), parameters: {'id': playerId});
      await conn.close();

      if (result.isEmpty) {
        return Response.ok('Player deleted');
      } else {
        return Response.notFound('Player not found');
      }
    } catch (e) {
      print('Error deleting player: $e');
      return Response.internalServerError();
    }
  }
}
