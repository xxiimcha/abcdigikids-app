import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/database_helper.dart';

class AddProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? profile;

  AddProfileScreen({this.profile});

  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pinController = TextEditingController();
  String? _selectedAvatar;
  List<String> _avatars = [
    'assets/avatars/1.png',
    'assets/avatars/2.png',
    'assets/avatars/3.png',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.profile != null) {
      _nameController.text = widget.profile!['name'];
      _pinController.text = widget.profile!['pin'];
      _selectedAvatar = widget.profile!['avatar'];
    } else {
      _selectedAvatar = _avatars.first;
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic> profile = {
        'name': _nameController.text.trim(),
        'pin': _pinController.text.trim(),
        'avatar': _selectedAvatar,
      };

      if (widget.profile != null) {
        profile['id'] = widget.profile!['id'];
        await dbHelper.updateProfile(profile);
      } else {
        await dbHelper.insertProfile(profile);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile != null ? 'Edit Profile' : 'Add Profile', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name', labelStyle: GoogleFonts.chewy()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pinController,
                decoration: InputDecoration(labelText: 'PIN', labelStyle: GoogleFonts.chewy()),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a PIN';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Select Avatar', style: GoogleFonts.chewy(fontSize: 18)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _avatars.map((avatar) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = avatar;
                      });
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(avatar),
                      radius: 30,
                      child: _selectedAvatar == avatar
                          ? Icon(Icons.check, color: Colors.white)
                          : Container(),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save', style: GoogleFonts.chewy()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                  textStyle: GoogleFonts.chewy(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
