import 'package:flutter/material.dart';
import 'pages/profile_selection_screen.dart';
import 'helpers/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'dart:async';  // Import for Timer
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }

  await DatabaseHelper().database; // Ensure database is initialized

  runApp(ABCDigikidsApp());
}

class ABCDigikidsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCDigikids',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.chewyTextTheme(), // Apply Chewy font
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ProfileSelectionScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to ABCDigikids!',
          style: GoogleFonts.chewy(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
