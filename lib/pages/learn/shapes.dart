import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';

class ShapesScreen extends StatefulWidget {
  final List<String> imagePaths;

  ShapesScreen({required this.imagePaths});

  @override
  _ShapesScreenState createState() => _ShapesScreenState();
}

class _ShapesScreenState extends State<ShapesScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  final FlutterTts flutterTts = FlutterTts();
  String recognizedText = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    flutterTts.setStartHandler(() {
      print("TTS started");
    });
    flutterTts.setCompletionHandler(() {
      print("TTS completed");
    });
    flutterTts.setErrorHandler((msg) {
      print("TTS error: $msg");
    });
    _speakCurrentWord(); // Speak the first word initially
  }

  @override
  void dispose() {
    _pageController.dispose();
    flutterTts.stop(); // Stop TTS when disposing
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < widget.imagePaths.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _speakCurrentWord(); // Speak the word when the page changes
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _speakCurrentWord(); // Speak the word when the page changes
    }
  }

  Future<void> _speakCurrentWord() async {
    String imagePath = widget.imagePaths[_currentPage];
    await _recognizeText(imagePath);
    String shape = _extractShapeFromImagePath(imagePath);
    print("Speaking: $shape $recognizedText");
    await flutterTts.speak("$shape $recognizedText");
  }

  String _extractShapeFromImagePath(String imagePath) {
    // Extract the shape name from the image path, assuming the format is assets/learn_shapes/shape.png
    return imagePath.split('/').last.split('.').first;
  }

  Future<void> _recognizeText(String imagePath) async {
    final directory = await getTemporaryDirectory();
    final tempPath = '${directory.path}/temp.png';

    // Copy image to temporary location
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    File(tempPath).writeAsBytesSync(bytes);

    // Recognize text from image using Google ML Kit
    final inputImage = InputImage.fromFilePath(tempPath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedTextObject = await textRecognizer.processImage(inputImage);

    recognizedText = recognizedTextObject.text.split('\n').last.trim(); // Get the last line and trim spaces
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          'Shapes',
          style: GoogleFonts.chewy(), // Apply Chewy font
        ),
        backgroundColor: Colors.redAccent, // Match the background color
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/default_avatar.jpg'), // example avatar, you can replace it with the user's avatar
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
                _speakCurrentWord(); // Speak the word when the page changes
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2 - 25,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 50),
              onPressed: _previousPage,
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2 - 25,
            child: IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white, size: 50),
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ShapesScreen(imagePaths: [
  'assets/learn_shapes/circle.png',
  'assets/learn_shapes/diamond.png',
  'assets/learn_shapes/heart.png',
  'assets/learn_shapes/oval.png',
  'assets/learn_shapes/rectangle.png',
  'assets/learn_shapes/square.png',
  'assets/learn_shapes/star.png',
  'assets/learn_shapes/triangle.png'
])));
