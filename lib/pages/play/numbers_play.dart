import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'numbers_identifying_game.dart';
import 'numbers_matching_game.dart';
import 'numbers_tracing_game.dart';
import 'numbers_pronunciation_game.dart'; // Import the Pronunciation game

class NumbersGameTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers Games', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildGameTypeButton(context, 'Identifying Numbers', NumbersIdentifyingGame()),
          _buildGameTypeButton(context, 'Matching Numbers', NumbersMatchingGame()),
          _buildGameTypeButton(context, 'Tracing Numbers', NumbersTracingGame()),
          _buildGameTypeButton(context, 'Pronunciation Numbers', NumbersPronunciationGame()), // Add Pronunciation game
        ],
      ),
    );
  }

  Widget _buildGameTypeButton(BuildContext context, String title, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
      },
      child: Text(
        title,
        style: GoogleFonts.chewy(fontSize: 18),
      ),
    );
  }
}
