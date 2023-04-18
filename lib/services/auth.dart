import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential userCred = await _auth.signInAnonymously();
      User? user = userCred.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign in with email
  // register
  // sign out
}
