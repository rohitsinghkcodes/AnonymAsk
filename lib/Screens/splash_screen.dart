import 'dart:async';
import 'package:anonym_ask/Helper/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_screen.dart';
import 'choose_avatar.dart';

class SplashScreen extends StatefulWidget {
  // static const id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
    getApiKey();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // colors: [Color(0xFF8C52FF), Color(0xFF5CE1E6)],
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    height: 40,
                    child: Image.asset('images/anonym_logo.png'),
                  ),
                ),
                const Text(
                  'D E V E L O P E D . B Y . R O H I T',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 1500), () async {
      navigateUser(); //It will redirect  after  1.5 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('userAvatar');

    if (user == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const ChooseAvatar()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const ChatScreen()));
    }
  }
}
