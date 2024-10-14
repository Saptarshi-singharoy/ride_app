import 'package:flutter/material.dart';
import 'package:ride_app/utils/themes/themes.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressedFunction;
  final Color backgroundColor;
  final String content;
  final IconData icon;

  const CustomButton(
      {super.key,
      required this.onPressedFunction,
      required this.backgroundColor,
      required this.content,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor, foregroundColor: Colors.white),
        onPressed: () {
          // widget.accept(widget.booking);
          onPressedFunction();
        },
        child: Row(
          children: [
            Icon(icon),
            Text(
              content,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
