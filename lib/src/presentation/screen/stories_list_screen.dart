import 'package:flutter/material.dart';

class StoriesListScreen extends StatelessWidget {
  final Function(String) onTapped;
  final Function() onCreateNewStory;
  final Function() onLogout;

  const StoriesListScreen({
    Key? key,
    required this.onTapped,
    required this.onLogout,
    required this.onCreateNewStory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoriesListScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("StoriesListScreen"),
          TextButton(
            onPressed: () => onTapped("test"),
            child: const Text("onTapped(test)"),
          ),
          TextButton(
            onPressed: onCreateNewStory,
            child: const Text("onCreateNewStory"),
          ),
          TextButton(
            onPressed: onLogout,
            child: const Text("onLogout"),
          ),
        ],
      ),
    );
  }
}
