import 'package:flutter/material.dart';

class OnBehalf extends StatefulWidget {
  const OnBehalf({super.key});

  @override
  State<OnBehalf> createState() => _OnBehalfState();
}

class _OnBehalfState extends State<OnBehalf> {
  final list = [];
  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Placeholder()
        : Center(
            child: Text('Nothing Here!'),
          );
  }
}
