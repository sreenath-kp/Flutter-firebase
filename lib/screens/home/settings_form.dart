// Settings form panel for changing user data
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
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
                  initialValue: userData?.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) => setState(() => _currentName = value),
                ),
                const SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars.isEmpty
                        ? userData!.sugars
                        : _currentSugars,
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
                  activeColor: Colors.brown[_currentStrength == 100
                      ? userData!.strength
                      : _currentStrength],
                  inactiveColor:
                      Colors.brown[_currentStrength]!.withOpacity(0.5),
                  value: (_currentStrength == 100
                          ? userData?.strength
                          : _currentStrength)!
                      .toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentStrength = value.round();
                    });
                  },
                ),
                // button
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.pink[400])),
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars.isEmpty
                            ? userData!.sugars
                            : _currentSugars,
                        _currentName.isEmpty ? userData!.name : _currentName,
                        _currentStrength == 100
                            ? userData!.strength
                            : _currentStrength);
                    Navigator.pop(context);
                    // } else {}
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
