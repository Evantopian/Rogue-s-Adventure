import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:postgres/postgres.dart';
import 'dart:io'; // Import dart:io

// Import the DbConnection class
import 'connect_db.dart';
import './handlers/player_handler.dart'; // Import the PlayerHandler class

void main() async {
  // Connect to the database
  Connection dbConnection;
  try {
    dbConnection = await DbConnection.connectToDatabase();
    print('Database connection successful!');
  } catch (e) {
    print('Error connecting to the database: $e');
    return;
  }

  // Create PlayerHandler instance
  final playerHandler = PlayerHandler();

  // Create a Cascade with middleware and handler
  final cascade = Cascade().add(playerHandler.router);

  // Create a Shelf handler using the Cascade
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(cascade.handler);

  // Serve the handler on the specified address and port
  final server = await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8080);

  // Print server information
  print('Server running on ${server.address}:${server.port}');
}

// Middleware to log requests
Middleware logRequests() {
  return (Handler innerHandler) {
    return (Request request) async {
      print('Received request for ${request.url}');
      var response = await innerHandler(request);
      print('Responding with ${response.statusCode}');
      return response;
    };
  };
}
