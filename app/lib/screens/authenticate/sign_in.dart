import 'dart:ui';

import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

void showBadCredentialsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Invalid Credentials'),
        content: const Text(
            'The username or password you entered is incorrect. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          title: const Text('Sign in to MyTask'),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              icon: const Icon(Icons.person, color: Colors.white),
              label: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),

              ),
            ),
          ]
      ),


      body: SingleChildScrollView(
        /// a form well designed to take the user's email and password
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                alignment: Alignment.center,
                child: Image.asset('assets/images/Logo.jpg'),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  // To do: sign in with email and password
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                    if (result == null) {
                      print('error signing in');
                      showBadCredentialsDialog(context);
                    } else {
                      print('signed in');
                      print(result.uid);
                    }
                  }
                },
                child: const Text('Sign in'),
              ),
              const SizedBox(height: 12.0),
              const Center(
                child: Text(
                  'or',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  // To do: sign in with google
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print('error signing in');
                  } else {
                    print('signed in');
                    print(result.uid);
                  }
                },
                child: const Text('Sign in Anonymously'),
              ),
            ],
          ),
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
