import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumbersTracingGame extends StatefulWidget {
  @override
  _NumbersTracingGameState createState() => _NumbersTracingGameState();
}

class _NumbersTracingGameState extends State<NumbersTracingGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracing Numbers', style: GoogleFonts.chewy()),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Trace the number 3',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: CustomPaint(
                painter: _NumberPainter(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}

class _NumberPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.2);
    path.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.2),
      radius: Radius.circular(50),
    );
    path.arcToPoint(
      Offset(size.width * 0.3, size.height * 0.6),
      radius: Radius.circular(50),
    );
    path.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.6),
      radius: Radius.circular(50),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
