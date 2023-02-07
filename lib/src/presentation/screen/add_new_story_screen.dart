import 'package:flutter/material.dart';

class AddNewStoryScreen extends StatelessWidget {
  final Function() onSubmit;
  const AddNewStoryScreen({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddNewStoryScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("AddNewStoryScreen"),
          TextButton(
            onPressed: onSubmit,
            child: const Text("onSubmit"),
          )
        ],
      ),
    );
  }
}
