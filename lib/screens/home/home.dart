import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        ),
      );
    }

    return StreamProvider<List<Brew>>.value(
      initialData: const [],
      value: DatabaseService(uid: '').brew,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          leading: IconButton(
              color: Colors.black,
              onPressed: () {
                showSettingsPanel();
              },
              icon: const Icon(Icons.person)),
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.logout_outlined),
              label: const Text('Logout'),
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black)),
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
