import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'learn/alphabets.dart';
import 'learn/numbers.dart';
import 'learn/shapes.dart';
import 'learn/colors.dart';

class LearnScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  LearnScreen({required this.profile});

  void _loadAlphabetImages(BuildContext context) {
    List<String> imagePaths = [];
    for (var i = 0; i < 26; i++) {
      imagePaths.add('assets/learn_abc/${String.fromCharCode(65 + i)}.png');
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlphabetsScreen(imagePaths: imagePaths),
      ),
    );
  }

  void _loadNumberImages(BuildContext context) {
    List<String> imagePaths = [];
    for (var i = 1; i <= 10; i++) {
      imagePaths.add('assets/learn_numbers/$i.png');
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NumbersScreen(imagePaths: imagePaths),
      ),
    );
  }

  void _loadShapeImages(BuildContext context) {
    List<String> imagePaths = [
      'assets/learn_shapes/circle.png',
      'assets/learn_shapes/diamond.png',
      'assets/learn_shapes/heart.png',
      'assets/learn_shapes/oval.png',
      'assets/learn_shapes/rectangle.png',
      'assets/learn_shapes/square.png',
      'assets/learn_shapes/star.png',
      'assets/learn_shapes/triangle.png'
    ];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShapesScreen(imagePaths: imagePaths),
      ),
    );
  }

  void _loadColorImages(BuildContext context) {
    List<String> imagePaths = [
      'assets/learn_colors/pink.png',
      'assets/learn_colors/green.png',
      'assets/learn_colors/yellow.png',
      'assets/learn_colors/blue.png',
      'assets/learn_colors/orange.png',
      'assets/learn_colors/red.png',
      'assets/learn_colors/brown.png',
      'assets/learn_colors/violet.png',
      'assets/learn_colors/white.png',
      'assets/learn_colors/black.png'
    ];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ColorsScreen(imagePaths: imagePaths),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          'Learn',
          style: GoogleFonts.chewy(), // Apply Chewy font
        ),
        backgroundColor: Colors.redAccent, // Match the background color
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(profile['avatar']),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _loadAlphabetImages(context),
              child: Text('Alphabets'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Set button color
                textStyle: GoogleFonts.chewy(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loadNumberImages(context),
              child: Text('Numbers'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Set button color
                textStyle: GoogleFonts.chewy(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loadColorImages(context),
              child: Text('Colors'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Set button color
                textStyle: GoogleFonts.chewy(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loadShapeImages(context),
              child: Text('Shapes'),
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
