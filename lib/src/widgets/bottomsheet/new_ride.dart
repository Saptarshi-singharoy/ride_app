import 'package:flutter/material.dart';
import 'package:ride_app/src/models/booking.model.dart';

enum GuestType { external, internal }

class NewRide extends StatefulWidget {
  const NewRide({super.key, required this.behalfMode});

  final bool behalfMode;

  @override
  State<NewRide> createState() => _NewRideState();
}

class _NewRideState extends State<NewRide> {
  final _formGlobalKey = GlobalKey<FormState>();

  final _fromController = TextEditingController();
  final _nameOfGuestController = TextEditingController();
  final _toController = TextEditingController();
  final _purposeController = TextEditingController();
  DateTime? _selectedDate;

  void _pickDate() async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year - 1, now.month);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    _nameOfGuestController.dispose();
    _purposeController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 25, 20, keyboardSpace + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book a new ride',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  if (widget.behalfMode)
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this feild is required';
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      controller: _nameOfGuestController,
                      decoration: InputDecoration(
                          label: Text(
                        'Name of Guest',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )),
                    ),
                  if (widget.behalfMode)
                    DropdownButtonFormField(
                      items: GuestType.values.map((g) {
                        return DropdownMenuItem(
                          child: Text(g.name),
                          value: g,
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this feild is required';
                      }
                      return null;
                    },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    controller: _fromController,
                    decoration: InputDecoration(
                        label: Text(
                      'From',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this feild is required';
                      }
                      return null;
                    },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    controller: _toController,
                    decoration: InputDecoration(
                        label: Text(
                      'To',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                  ),
                  TextButton.icon(
                    onPressed: _pickDate,
                    icon: Icon(Icons.calendar_month),
                    label: Text(_selectedDate != null
                        ? formatter.format(_selectedDate!)
                        : 'Pick a date'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this feild is required';
                      }
                      return null;
                    },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    controller: _purposeController,
                    decoration: InputDecoration(
                        label: Text(
                      'Purpose',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            onPressed: () {
                              // _formGlobalKey.currentState?.save();
                              if (_formGlobalKey.currentState!.validate())
                                Navigator.pop(context);
                            },
                            child: Text('Book')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
