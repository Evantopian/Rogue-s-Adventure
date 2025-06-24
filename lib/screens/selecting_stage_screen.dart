import 'package:flutter/material.dart';
import './game_settings.dart';
import './battle_screen.dart';
import './camp_screen.dart';

class SelectingStageScreen extends StatelessWidget {
  Widget _buildScaledButton(BuildContext context, Function() onPressed,
      {double heightScale = 0.0, double widthScale = 0.0}) {
    final buttonWidth = 60.0; // Set your desired button width
    final buttonHeight = 60.0; // Set your desired button height

    return Positioned(
      bottom: MediaQuery.of(context).size.height * heightScale,
      left: MediaQuery.of(context).size.width * widthScale,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  void _goToBattle(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BattleScreen()),
    );
  }

  void _goToCamp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CampScreen()),
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
                image: AssetImage('assets/background/stage_select_1.png'),
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
                              8), // Adjust the spacing between player name and health
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
                          builder: (context) => GameSettingsPage(),
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
          // Button that Scales with Screen Size
          _buildScaledButton(context, () {
            _goToBattle(context);
          }, heightScale: 0.205, widthScale: 0.092),
          _buildScaledButton(context, () {
            _goToBattle(context);
          }, heightScale: 0.612, widthScale: 0.20),
          _buildScaledButton(context, () {
            _goToBattle(context);
          }, heightScale: 0.62, widthScale: 0.434),
          _buildScaledButton(context, () {
            _goToBattle(context);
          }, heightScale: 0.23, widthScale: 0.536),
          _buildScaledButton(context, () {
            _goToBattle(context);
          }, heightScale: 0.4, widthScale: 0.86),
          _buildScaledButton(context, () {
            _goToCamp(context);
          }, heightScale: 0.23, widthScale: 0.33),
          _buildScaledButton(context, () {
            _goToCamp(context);
          }, heightScale: 0.62, widthScale: 0.655),
        ],
      ),
    );
  }
}
