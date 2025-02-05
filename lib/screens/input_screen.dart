import 'package:flutter/material.dart';
import 'package:robot_controller/services/shared_preferences_service.dart';
import 'controller_screen.dart';

class NameInputScreen extends StatefulWidget {
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _controller = TextEditingController();

  void _saveAndNavigate() async {
    if (_controller.text.isNotEmpty) {
      await SharedPreferencesService.saveString('robotName', _controller.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ControlScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Robot Name')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Robot Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAndNavigate,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
