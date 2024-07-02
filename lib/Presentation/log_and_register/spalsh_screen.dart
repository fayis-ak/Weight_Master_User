import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master/Presentation/home/myhome.dart';
import 'package:weigh_master/Presentation/log_and_register/selection_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotologin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Weigh Master',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotologin() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return FirebaseAuth.instance.currentUser != null
          ? Myhome()
          : SelectionPage();
    }), (route) => false);
  }
}
