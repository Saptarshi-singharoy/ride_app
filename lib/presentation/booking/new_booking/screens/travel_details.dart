import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_app/core/widgets/text_field_custom.dart';
import 'package:ride_app/utils/themes/themes.dart';

enum TravelLocation { Local, Outstation }

class TravelDetails extends StatefulWidget {
  final List<TextEditingController> controllers;
  const TravelDetails({super.key, required this.controllers});

  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  String _travelLocation = TravelLocation.Outstation.name;

  @override
  Widget build(BuildContext context) {
    final sectionDivColor = Colors.grey[50];
    final headTextStyle = provideTextTheme(context).bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    final dividerColor = provideColorScheme(context).primary;
    final feildTextStyle = provideTextTheme(context)
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.primary);
    final indentColor = provideColorScheme(context).secondary.withOpacity(0.5);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: sectionDivColor,
      child: Column(
        children: [
          Text(
            "Travel Details",
            style: headTextStyle,
          ),
          Divider(
            color: dividerColor,
            height: 5,
          ),
          DropdownButtonFormField(
            validator: (value) {
              if (value == null || value == 0) {
                return 'this feild is required';
              }
              return null;
            },
            items: TravelLocation.values.map((g) {
              return DropdownMenuItem(
                value: g,
                child: Text(g.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _travelLocation = value!.name;
              });
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: indentColor), // Default color
                ),
                label: Text("Location of travel (Local / Outstation)",
                    style: feildTextStyle)),
          ),
          TextFeildCustom(
              controller: widget.controllers[0], labelText: "Destination"),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this feild is required';
              }
              if (int.parse(value) > 10) {
                return 'value should be less than 10';
              }
              return null;
            },
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
            controller: widget.controllers[1],
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: indentColor), // Default color
                ),
                label:
                    Text('Number of person travelling', style: feildTextStyle)),
          ),
        ],
      ),
    );
  }
}
