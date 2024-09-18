import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'learn_screen.dart';
import 'play_screen.dart';
import 'profile_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  HomeScreen({required this.profile});

  void _showChangeAccountModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change Account',
                style: GoogleFonts.chewy(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfileSelectionScreen()),
                  );
                },
                child: Text('Switch Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Set button color
                  textStyle: GoogleFonts.chewy(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.chewy(), // Apply Chewy font
        ),
        backgroundColor: Colors.redAccent, // Match the background color
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _showChangeAccountModal(context),
              child: CircleAvatar(
                backgroundImage: AssetImage(profile['avatar']),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlayScreen()),
                );
              },
              child: Text('Play'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Set button color
                textStyle: GoogleFonts.chewy(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LearnScreen(profile: profile)),
                );
              },
              child: Text('Learn'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Set button color
                textStyle: GoogleFonts.chewy(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
