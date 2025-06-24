import 'package:flutter/material.dart';
import './game_settings.dart';
import './world_map_screen.dart';
import './battle_result_screen.dart'; // Import the battle results screen

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  int playerHealthPoints = 50; // Initial player health points
  int enemyHealthPoints = 40; // Initial enemy health points

  void decreaseHealth(bool isPlayer) {
    setState(() {
      // Decrease health points
      if (isPlayer) {
        playerHealthPoints -= 10;
        playerHealthPoints = playerHealthPoints.clamp(0, 50);
      } else {
        enemyHealthPoints -= 10;
        enemyHealthPoints = enemyHealthPoints.clamp(0, 40);
      }

      if (playerHealthPoints == 0) {
        // Show game over dialog when player health points reach 0
        showGameOverDialog(context);
      }
    });
  }

  void showGameOverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Game Over! You died!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      // Navigate back to the world map after dialog is dismissed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorldMapPage()),
      );
    });
  }

  void goToBattleResultsScreen() {
    // Navigate to the battle results screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BattleResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/ruins_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Custom Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.grey[700], // Grey color for the navigation bar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Player Name and Health
                  Row(
                    children: [
                      Text(
                        'Player Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width:
                            8, // Adjust the spacing between player name and health
                      ),
                      // Player Health Indicator
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/heart.png',
                            width: 24, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
                          ),
                          SizedBox(width: 4),
                          Text(
                            '$playerHealthPoints/50', // Display player health points
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Settings Icon
                  GestureDetector(
                    onTap: () {
                      // Navigate to settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameSettingsPage(fromBattleOrCamp: true),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/gear.png',
                      width: 24, // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      color: Colors.white, // Color of the settings icon
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Player Asset with Health Bar
          Positioned(
            left: MediaQuery.of(context).size.height /
                5, // Adjust the left position as needed
            top: MediaQuery.of(context).size.height / 3.5, // Center vertically
            child: Column(
              children: [
                Image.asset(
                  'assets/images/player.png',
                  width: MediaQuery.of(context).size.width *
                      0.25, // Scale with screen width
                  height: MediaQuery.of(context).size.height *
                      0.25, // Scale with screen height
                ),
                SizedBox(
                    height:
                        8), // Add spacing between player asset and health bar
                Container(
                  width: 100,
                  height: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[400],
                      value: playerHealthPoints / 50,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Enemy Asset with Health Bar
          Positioned(
            left: MediaQuery.of(context).size.width * 0.6, // Adjust position
            top: MediaQuery.of(context).size.height / 3, // Center vertically
            child: Column(
              children: [
                Image.asset(
                  'assets/images/enemy_placeholder.png', // Placeholder enemy asset
                  width: MediaQuery.of(context).size.width *
                      0.15, // Adjust the width as needed
                  height: MediaQuery.of(context).size.height *
                      0.15, // Adjust the height as needed
                ),
                SizedBox(
                    height:
                        8), // Add spacing between enemy asset and health bar
                Container(
                  width: 100,
                  height: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[400],
                      value: enemyHealthPoints / 40,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Gray Box for Player Cards
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.width *
                  0.15, // Adjust the height as needed
              color: Colors.grey
                  .withOpacity(0.7), // Transparent gray color for the box
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Add cards here
                  Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Scale with screen width
                      height: MediaQuery.of(context).size.height *
                          0.3, // Scale with screen height
                      child: Image.asset(
                        'assets/full_cards/assassin_sacrament.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Scale with screen width
                      height: MediaQuery.of(context).size.height *
                          0.3, // Scale with screen height
                      child: Image.asset(
                        'assets/full_cards/quick_start.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Scale with screen width
                      height: MediaQuery.of(context).size.height *
                          0.3, // Scale with screen height
                      child: Image.asset(
                        'assets/full_cards/amateur_ambush.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Scale with screen width
                      height: MediaQuery.of(context).size.height *
                          0.3, // Scale with screen height
                      child: Image.asset(
                        'assets/full_cards/quick_block.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 740.0,
            bottom: 16.0,
            child: ElevatedButton(
              onPressed: () {
                decreaseHealth(true); // Decrease player health points
              },
              child: Text('-'),
            ),
          ),
          // Button to navigate to battle results screen
          Positioned(
            left: 1.0,
            right: 740.0,
            bottom: 16.0,
            child: ElevatedButton(
              onPressed: goToBattleResultsScreen,
              child: Text('->'),
            ),
          ),
        ],
      ),
    );
  }
}
