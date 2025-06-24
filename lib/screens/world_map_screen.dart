import 'package:flutter/material.dart';
import './selecting_stage_screen.dart';

class WorldMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/world_map_full.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned GestureDetector for the area where the button is
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.82, // Fractional position for y-coordinate
            left: MediaQuery.of(context).size.width *
                0.317, // Fractional position for x-coordinate
            child: GestureDetector(
              onTap: () {
                // Navigate to the stage selection screen (SelectingStageScreen)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectingStageScreen(),
                  ),
                );
              },
              child: ClipOval(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.030, // Fractional size for width
                  height: MediaQuery.of(context).size.height *
                      0.06, // Fractional size for height
                  color: Colors.transparent, // Make the container transparent
                ),
              ),
            ),
          ),
          // Add more Positioned GestureDetector widgets for other areas/buttons
        ],
      ),
    );
  }
}
