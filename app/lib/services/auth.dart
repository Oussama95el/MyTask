import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytask1/models/user.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }


  // Sign in anonymously
  Future signInAnon() async {
    try {
      final userCredentials = await _auth.signInAnonymously();
      User? user = userCredentials.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          print('Anonymous sign-in not enabled.');
          break;
        case 'network-request-failed':
          print('Network error.');
          break;
        default:
          print('Unknown error.');
          break;
      }
      return null;
    }
  }

  // Sign in with email and password



  // Sign in with Google


  // Register with email and password

  // Sign out
}