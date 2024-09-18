import 'package:flutter/material.dart';
import 'play/alphabets_game_type.dart';
import 'play/shapes_play.dart';
import 'play/numbers_play.dart'; // Import the NumbersGameTypePage
import 'play/colors_play.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Categories', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCategoryButton(context, 'Alphabets', AlphabetsGameTypePage()),
          _buildCategoryButton(context, 'Shapes', ShapesPlayPage()),
          _buildCategoryButton(context, 'Numbers', NumbersGameTypePage()), // Use NumbersGameTypePage
          _buildCategoryButton(context, 'Colors', ColorsPlayPage()),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, Widget page) {
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
