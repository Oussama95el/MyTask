import 'package:flutter/material.dart';
import 'package:mytask1/models/user.dart';
import 'package:mytask1/screens/authenticate/Authenticate.dart';
import 'package:mytask1/screens/home/home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);
    // return either the Home or Authenticate widget

    if (user == null) {
      return const Authenticate();
    } else {
      return const HomePage(title:"My Task Manager App");
    }
  }
}