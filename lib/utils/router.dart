import 'package:card_game/screens/flame_game_screen.dart';
import 'package:flutter/material.dart';
import '../screens/menu_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/homepage.dart';
import '../screens/settings.dart';
import '../screens/world_map_screen.dart';
import '../screens/selecting_stage_screen.dart';
import '../screens/battle_screen.dart';
import '../screens/camp_screen.dart';

// refer to figma to add seperate routes.
// defintely need to cache some
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MenuScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: 'Flutter Demo Home Page'));
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/map':
        return MaterialPageRoute(builder: (_) => WorldMapPage());
      case '/selectstage':
        return MaterialPageRoute(builder: (_) => SelectingStageScreen());
      case '/battle':
        return MaterialPageRoute(builder: (_) => BattleScreen());
      case '/camp':
        return MaterialPageRoute(builder: (_) => CampScreen());
      case '/test':
        return MaterialPageRoute(builder: (_) => RouterGameScreen());
      default:
        // If there is no such named route, return error route
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('404 - Page Not Found'),
        ),
      );
    });
  }
}
