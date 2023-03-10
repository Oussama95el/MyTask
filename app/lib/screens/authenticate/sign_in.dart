import 'dart:ui';

import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

 final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          title: const Text('Sign in to MyTask')),
      body: Container(
        /// a form well designed to take the user's email and password
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: const Text('Sign in anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              print(result);
            }
          },
        ),
      ),
    );
  }
}

// child: Form(
// child: Column(
// children: [
// const SizedBox(height: 20.0),
// TextFormField(
// decoration: const InputDecoration(
// hintText: 'Email',
// ),
// ),
// const SizedBox(height: 20.0),
// TextFormField(
// decoration: const InputDecoration(
// hintText: 'Password',
// ),
// obscureText: true,
// ),
// const SizedBox(height: 20.0),
// ElevatedButton(
// onPressed: () {
// // To do: sign in with email and password
// },
// child: null,
// ),
// const SizedBox(height: 12.0),
// const Text(
// 'or',
// style: TextStyle(color: Colors.grey),
// ),
// const SizedBox(height: 12.0),
// ElevatedButton(
// onPressed: () {
// // To do: sign in with google
// },
// child: null,
// ),
// ],
// ),
// )
