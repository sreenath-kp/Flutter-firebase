import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Create user object
  MyUser _userFromFirebase(User? user) {
    return MyUser(uid: user!.uid);
    // null check added
    // ternary operator used in tutorial instead
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
    // .map((event) => _userFromFirebase(event));
  }

  //sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential userCred = await _auth.signInAnonymously();
      User? user = userCred.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign in with email
  // register
  // sign out
}
