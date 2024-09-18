import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShapeSortingGame extends StatefulWidget {
  @override
  _ShapeSortingGameState createState() => _ShapeSortingGameState();
}

class _ShapeSortingGameState extends State<ShapeSortingGame> {
  final List<String> shapes = ["Circle", "Square", "Triangle", "Rectangle"];
  final Map<String, List<String>> categories = {
    "2D Shapes": [],
    "3D Shapes": []
  };
  String feedbackMessage = '';

  void sortShape(String shape, String category) {
    setState(() {
      categories[category]?.add(shape);
      shapes.remove(shape);
      if (shapes.isEmpty) {
        feedbackMessage = "All shapes sorted!";
      } else {
        feedbackMessage = "Keep going!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shape Sorting', style: GoogleFonts.chewy()),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Sort the shapes into 2D and 3D categories!',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: shapes.map((shape) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle shape selection
                        },
                        child: Text(
                          shape,
                          style: GoogleFonts.chewy(fontSize: 32),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: categories.keys.map((category) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle category selection
                        },
                        child: Text(
                          category,
                          style: GoogleFonts.chewy(fontSize: 32),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    feedbackMessage,
                    style: GoogleFonts.chewy(
                        fontSize: 24,
                        color: feedbackMessage == "All shapes sorted!"
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (feedbackMessage == "All shapes sorted!") {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    feedbackMessage =
                    "Please complete sorting the shapes correctly first!";
                  });
                }
              },
              child: Text(
                'FINISH',
                style: GoogleFonts.chewy(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
