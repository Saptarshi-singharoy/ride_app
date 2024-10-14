import 'package:flutter/material.dart';
import 'package:ride_app/data/models/booking.model.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker(
      {super.key,
      required this.picker,
      required this.selectedValue,
      required this.val});

  final void Function() picker;
  final dynamic selectedValue;
  final String? val;

  @override
  Widget build(BuildContext context) {
    final indentColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.5);
    return Expanded(
      child: GestureDetector(
        onTap: picker,
        child: Stack(children: [
          TextFormField(
            readOnly: true,
            onTap: picker,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: indentColor), // Default color
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: Icon(
                  val == "Date" ? Icons.calendar_month : Icons.lock_clock,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
          Positioned(
            top: 15,
            child: val == "Date"
                ? Text(
                    selectedValue != null
                        ? formatter.format(selectedValue!)
                        : "Select a ${val!}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  )
                : Text(
                    selectedValue,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
          )
        ]),
      ),
    );
  }
}
