import 'package:flutter/material.dart';

class StoriesListScreen extends StatelessWidget {
  final Function(String) onTapped;
  final Function() onLogout;

  const StoriesListScreen({
    Key? key,
    required this.onTapped,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
