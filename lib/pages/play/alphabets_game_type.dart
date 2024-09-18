import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alphabets_play.dart';
import 'alphabets_tracing_letters.dart'; // Import the new tracing letters page

class AlphabetsGameTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabets Games', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildGameTypeButton(context, 'Tracing Letters', TracingLettersPage()), // Use the new tracing letters page
          _buildGameTypeButton(context, 'Identifying Letters', AlphabetsPlayPage()),
          _buildGameTypeButton(context, 'Matching Letters', PlaceholderWidget()), // Replace PlaceholderWidget with the actual matching letters page
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

class PlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coming Soon', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Text(
          'This game type is coming soon!',
          style: GoogleFonts.chewy(fontSize: 24),
        ),
      ),
    );
  }
}
