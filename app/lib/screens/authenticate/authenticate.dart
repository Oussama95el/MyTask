import 'package:flutter/material.dart';
import 'package:mytask1/screens/authenticate/register.dart';
import 'package:mytask1/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {


  @override
  Widget build(BuildContext context) {
    return  const SignIn();
  }
}
