import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master/Data/Model/user_model.dart';
import 'package:weigh_master/Data/db_service.dart';
import 'package:weigh_master/Presentation/home/myhome.dart';
import 'package:weigh_master/Presentation/log_and_register/spalsh_screen.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  Future<void> registerWithEmailAndPassword(
      String email, String password, String name, context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) {
        DBService()
            .addUser(
                userCredential.user!.uid,
                UserModel(
                    address: "",
                    email: email,
                    name: name,
                    password: password,
                    uid: userCredential.user!.uid))
            .then((value) {
          showCustomeDiologeu(context, "Registration Successful", true);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Myhome()),
              (conext) => false);
        });

        print('User registration successful: ${userCredential.user!.uid}');
      });
    } catch (e) {
      showCustomeDiologeu(
          context, "Registration Failed :${e.runtimeType}", false);

      print('Error registering user: $e');
    }
  }

  Future<void> loginWithEmailPassword(
      String email, String password, context) async {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      showCustomeDiologeu(context, "Login Successful!", true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Myhome(),
        ),
      );
    }).catchError((error) {
      showCustomeDiologeu(context, "Login Failed: $error", false);
    });
  }

  Future sighout(context) async {
    await auth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (route) => false));
  }

  showCustomeDiologeu(context, message, bool isSuccess) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ));
  }
}
