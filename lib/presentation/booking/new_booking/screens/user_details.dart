import 'package:flutter/material.dart';
import 'package:ride_app/core/widgets/text_field_custom.dart';
import 'package:ride_app/utils/themes/themes.dart';

enum Departments { department1, department2, department3, department4 }

class UserDetailsForm extends StatefulWidget {
  final List<TextEditingController> controllers;
  bool? editable;
  final void Function(Departments?) changeDepartmentFunction;
  UserDetailsForm(
      {super.key,
      this.editable,
      required this.controllers,
      required this.changeDepartmentFunction});

  @override
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            "User Details",
            style: provideTextTheme(context).bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            color: provideColorScheme(context).primary,
            height: 0,
          ),
          TextFeildCustom(
              controller: widget.controllers[0], labelText: "Name of User"),
          TextFeildCustom(
            controller: widget.controllers[1],
            labelText: 'Contact of user',
            inputType: TextInputType.phone,
          ),
          DropdownButtonFormField(
            validator: (value) {
              if (value == null || value.name.isEmpty) {
                return 'this feild is required';
              }
              return null;
            },
            items: Departments.values.map((g) {
              return DropdownMenuItem(
                value: g,
                child: Text(g.name),
              );
            }).toList(),
            onChanged: (value) {
              widget.changeDepartmentFunction(value);
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: provideColorScheme(context)
                          .secondary
                          .withOpacity(0.5)), // Default color
                ),
                label: Text(
                  "Department",
                  style: provideTextTheme(context)
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )),
          ),
        ],
      ),
    );
  }
}
