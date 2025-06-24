import 'package:flutter/material.dart';
import './game_settings.dart';
import './selecting_stage_screen.dart';

class BattleResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/background/ruins_1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Gray Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          // Custom Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.grey[700],
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
                        width: 8,
                      ),
                      // Health Indicator
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/heart.png',
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '50/50', // Placeholder for health value
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
                          builder: (context) => GameSettingsPage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/gear.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Overlay for Battle Results Text
          Positioned.fill(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/golden_banner.png',
                    width: 400,
                    height: 400,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height /
                        8, // Adjust the position as needed
                    child: Text(
                      'Choose a card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Invisible Gesture Detectors for the Cards
          Positioned(
            top: MediaQuery.of(context).size.height / 8 +
                50, // Adjust position as needed
            left: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectingStageScreen()),
                    );
                  },
                  child: Image.asset(
                    'assets/full_cards/last_stand.png',
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height / 1.75,
                  ),
                ),
                // Second Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectingStageScreen()),
                    );
                  },
                  child: Image.asset(
                    'assets/full_cards/fatal_ambush.png',
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height / 1.75,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
