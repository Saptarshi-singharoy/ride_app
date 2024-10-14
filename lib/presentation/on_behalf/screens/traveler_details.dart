import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/widgets/text_field_custom.dart';
import 'package:ride_app/presentation/booking/new_booking/screens/user_details.dart';
import 'package:ride_app/utils/themes/themes.dart';

enum EmployeeType { internal, external }

class TravelerDetails extends ConsumerStatefulWidget {
  const TravelerDetails({super.key});

  @override
  ConsumerState<TravelerDetails> createState() => _TravelerDetailsState();
}

class _TravelerDetailsState extends ConsumerState<TravelerDetails> {
  final _nameOfEmp = TextEditingController();
  final _contactOfEmp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            "Travaler Details",
            style: provideTextTheme(context).bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            color: provideColorScheme(context).primary,
            height: 0,
          ),
          DropdownButtonFormField(
            validator: (value) {
              if (value == null || value.name.isEmpty) {
                return 'this feild is required';
              }
              return null;
            },
            items: EmployeeType.values.map((g) {
              return DropdownMenuItem(
                value: g,
                child: Text(g.name),
              );
            }).toList(),
            onChanged: (value) {
              // widget.changeDepartmentFunction(value);
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: provideColorScheme(context)
                          .secondary
                          .withOpacity(0.5)), // Default color
                ),
                label: Text(
                  "Employee Type",
                  style: provideTextTheme(context)
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )),
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
              // widget.changeDepartmentFunction(value);
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: provideColorScheme(context)
                          .secondary
                          .withOpacity(0.5)), // Default color
                ),
                label: Text(
                  "Departments",
                  style: provideTextTheme(context)
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )),
          ),
          TextFeildCustom(
            controller: _nameOfEmp,
            labelText: 'Name of Employee',
            inputType: TextInputType.phone,
          ),
          TextFeildCustom(
              controller: _contactOfEmp, labelText: "Contact of Employee"),
        ],
      ),
    );
    ;
  }
}
