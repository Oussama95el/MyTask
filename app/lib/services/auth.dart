import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytask1/models/user.dart';

import 'database.dart';


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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredentials.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          print('No user found for that email.');
          break;
        case 'wrong-password':
          print('Wrong password provided for that user.');
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


  // Sign in with Google


  // Register with email and password
  Future registerWithEmailAndPassword(String fullName, String email, String password) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredentials.user;

      // Create a new document for the user with the uid
      // await DatabaseService(uid: user!.uid).updateUserData('[Task title]', 'Medium', '2023-3-14', '15:00', false, 'Daily');

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          print('The account already exists for that email.');
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

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("Error signing out: ${e.toString()}");
      return null;
    }
  }
}