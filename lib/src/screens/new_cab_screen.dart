import 'package:flutter/material.dart';
import 'package:ride_app/src/models/booking.model.dart';

enum GuestType { external, internal }

class NewCabScreen extends StatefulWidget {
  const NewCabScreen({super.key, required this.behalfMode});

  final bool behalfMode;

  @override
  State<NewCabScreen> createState() => _NewCabScreenState();
}

class _NewCabScreenState extends State<NewCabScreen> {
  final _formGlobalKey = GlobalKey<FormState>();

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _nameOfGuestController = TextEditingController();
  final _purposeController = TextEditingController();
  final _extraFeild1 = TextEditingController();
  final _extraFeild2 = TextEditingController();
  final _extraFeild3 = TextEditingController();
  final _extraFeild4 = TextEditingController();

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
  void initState() {
    // TODO: implement initState
    print(widget.behalfMode);
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
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: _pickDate,
                    icon: Icon(Icons.calendar_month),
                    label: Text(_selectedDate != null
                        ? formatter.format(_selectedDate!)
                        : 'Pick a date'),
                  ),
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
                          value: g,
                          child: Text(g.name),
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
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this feild is required';
                      }
                      return null;
                    },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    controller: _extraFeild1,
                    decoration: InputDecoration(
                        label: Text(
                      'Extra Feild 1',
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
                    controller: _extraFeild2,
                    decoration: InputDecoration(
                        label: Text(
                      'Extra Feild 2',
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
                    controller: _extraFeild3,
                    decoration: InputDecoration(
                        label: Text(
                      'Extra Feild 3',
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
                    controller: _extraFeild4,
                    decoration: InputDecoration(
                        label: Text(
                      'Extra Feild 4',
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
                              // Navigator.pop(context);
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
                              // if (_formGlobalKey.currentState!.validate())
                              //   Navigator.pop(context);
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
