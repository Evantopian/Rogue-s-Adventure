import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import SystemChrome class
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import './utils/router.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final game = MainGame();

  // Set fullscreen mode on app startup
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // runApp(MyApp(game: kDebugMode ? MainGame() : game));
  // runApp(GameWidget(game: kDebugMode ? MainGame() : game));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(primary: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
