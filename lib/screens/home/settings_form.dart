// Settings form panel for changing user data
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  // form values
  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 100;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'User preferences',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a name' : null,
              onChanged: (value) => setState(() => _currentName = value),
            ),
            const SizedBox(height: 20.0),
            // dropdown
            DropdownButtonFormField(
                decoration: textInputDecoration,
                value: _currentSugars.isEmpty ? '0' : _currentSugars,
                items: sugars
                    .map((sugar) => DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _currentSugars = value ?? '0';
                  });
                }),
            // slider
            Slider(
              min: 100,
              max: 900,
              divisions: 8,
              activeColor: Colors.brown[_currentStrength],
              inactiveColor: Colors.brown[_currentStrength]!.withOpacity(0.5),
              value: _currentStrength.toDouble(),
              onChanged: (value) {
                setState(() {
                  _currentStrength = value.round();
                });
              },
            ),
            // button
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.pink[400])),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
