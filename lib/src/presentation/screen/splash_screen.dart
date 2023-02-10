import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
              child: Text(
            "StoryApp",
            style: TextStyle(fontSize: 30),
          )),
          Center(child: Text("Loading...")),
        ],
      ),
    );
  }
}
