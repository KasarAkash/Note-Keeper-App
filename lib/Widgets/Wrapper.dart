// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper_app/Screens/signup.dart';

import '../Screens/HomePage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return const HomePage();
    } else {
      return const SignUpPage();
    }
  }
}
