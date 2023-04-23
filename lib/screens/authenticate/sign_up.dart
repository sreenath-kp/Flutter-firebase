import 'package:flutter/material.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign Up to Brew Crew'),
          actions: [
            TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text('Sign In'),
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black)),
            )
          ]),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) => value!.length < 6 ? 'Password should be atleat 6 characters long' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.pink[400]),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(email);
                    print(password);
                  }
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
