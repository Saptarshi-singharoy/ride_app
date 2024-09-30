import 'package:flutter/material.dart';

class TextFeildCustom extends StatelessWidget {
  const TextFeildCustom(
      {super.key, required this.controller, required this.labelText});

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final indentColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.5);

    final feildTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.secondary);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this feild is required';
        }
        return null;
      },
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: indentColor), // Default color
          ),
          label: Text(labelText, style: feildTextStyle)),
    );
  }
}
