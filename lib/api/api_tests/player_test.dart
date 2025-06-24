import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'dart:io'; // Import dart:io
import '../models/player.dart';

void main() {
  final serverHost = InternetAddress.loopbackIPv4.address; // Use .address property
  final serverPort = 8080;

  late http.Client client;
  late Uri baseUrl;

  setUp(() {
    client = http.Client();
    baseUrl = Uri.parse('http://$serverHost:$serverPort');
  });

  tearDown(() {
    client.close();
  });

  group('Player API', () {
    test('Create player', () async {
      final player = Player('1', 'testuser', 'password');
      final response = await client.post(
        baseUrl.resolve('/player'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(player.toJson()),
      );
      expect(response.statusCode, 200);
      expect(jsonDecode(response.body), player.toJson());
    });

    test('Get player', () async {
      final response = await client.get(baseUrl.resolve('/player'));
      expect(response.statusCode, 200);
      final player = Player.fromJson(jsonDecode(response.body));
      expect(player.username, 'testuser');
    });

    test('Update player', () async {
      final updatedPlayer = Player('1', 'updateduser', 'newpassword', stage: 2, experience: 100);
      final response = await client.put(
        baseUrl.resolve('/player'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedPlayer.toJson()),
      );
      expect(response.statusCode, 200);
      expect(jsonDecode(response.body), updatedPlayer.toJson());
    });

    test('Delete player', () async {
      final response = await client.delete(baseUrl.resolve('/player'));
      expect(response.statusCode, 200);
      expect(response.body, 'Player deleted');
    });
  });
}