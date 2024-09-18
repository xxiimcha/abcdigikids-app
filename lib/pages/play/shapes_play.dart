import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shape_drawing_game.dart';
import 'shape_identification_game.dart';
import 'shape_sorting_game.dart';

class ShapesPlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shapes Games', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildGameTypeButton(context, 'Drawing Shapes', ShapeDrawingGame()),
          _buildGameTypeButton(context, 'Identifying Shapes', ShapeIdentificationGame()),
          _buildGameTypeButton(context, 'Sorting Shapes', ShapeSortingGame()),
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
