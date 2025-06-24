import 'package:flutter/material.dart';
import './game_settings.dart';

class CampScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/camp_screen.png'),
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
                      // Health Indicator
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/heart.png',
                            width: 24, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
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
                          builder: (context) => GameSettingsPage(
                            fromBattleOrCamp: true,
                          ),
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
          // Image Assets in the Middle
          Positioned.fill(
            child: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/panel_blue.png',
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.5,
                      ),
                      Image.asset(
                        'assets/images/panel_blue.png',
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.5,
                      ),
                    ],
                  ),
                  Positioned(
                    top: screenHeight * 0.175, // Adjust positioning as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/bed.png',
                          width: screenWidth * 0.19,
                          height: screenHeight * 0.15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Rest (+ 25 HP)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.66, // Adjust positioning as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/smithing.png',
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Smith (Upgrade a Card)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
