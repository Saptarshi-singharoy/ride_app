import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/data/dummy_onbehalf_data.dart';
import 'package:ride_app/src/models/booking.model.dart';
import 'package:ride_app/src/models/on_behalf.model.dart';
import 'package:ride_app/src/screens/new_booking/new_cab_screen.dart';
import 'package:ride_app/src/widgets/booked_item_card.dart';
import 'package:ride_app/src/widgets/bottomsheet/booked_onbehaf_card.dart';

class OnBehalf extends StatefulWidget {
  const OnBehalf({super.key, required this.behalfMode});

  final bool behalfMode;

  @override
  State<OnBehalf> createState() => _OnBehalfState();
}

class _OnBehalfState extends State<OnBehalf> {
  final list = [];
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

  GuestType guestType = GuestType.external;

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

  void _clearAllFeilds() {
    _nameOfGuestController.clear();
    _fromController.clear();
    _toController.clear();
    _purposeController.clear();
    _extraFeild1.clear();
    _extraFeild2.clear();
    _extraFeild3.clear();
    _extraFeild4.clear();
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

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const TabBar(
              tabs: [
                Tab(
                  text: "New Booking",
                ),
                Tab(
                  text: "Booked",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SizedBox(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.name.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              value: guestType,
                              items: GuestType.values.map((g) {
                                return DropdownMenuItem(
                                  value: g,
                                  child: Text(g.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                // print(guestType);
                                // print(value);
                                setState(() {
                                  guestType = value!;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _fromController,
                              decoration: InputDecoration(
                                  label: Text(
                                'From',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _toController,
                              decoration: InputDecoration(
                                  label: Text(
                                'To',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _purposeController,
                              decoration: InputDecoration(
                                  label: Text(
                                'Purpose',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _extraFeild1,
                              decoration: InputDecoration(
                                  label: Text(
                                'Extra Feild 1',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _extraFeild2,
                              decoration: InputDecoration(
                                  label: Text(
                                'Extra Feild 2',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _extraFeild3,
                              decoration: InputDecoration(
                                  label: Text(
                                'Extra Feild 3',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'this feild is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: _extraFeild4,
                              decoration: InputDecoration(
                                  label: Text(
                                'Extra Feild 4',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  onPressed: () {
                                    if (_formGlobalKey.currentState!
                                        .validate()) {
                                      final results = {
                                        'nameOfGuest':
                                            _nameOfGuestController.text,
                                        'from': _fromController.text,
                                        'to': _toController.text,
                                        'purpose': _purposeController.text,
                                        'guestType': guestType.name,
                                        'date': _selectedDate.toString(),
                                        'ex1': _extraFeild1.text,
                                        'ex2': _extraFeild2.text,
                                        'ex3': _extraFeild3.text,
                                        'ex4': _extraFeild4.text,
                                      };
                                      dummyOnbehalfData
                                          .add(OnBehalfModel.fromJson(results));
                                      _formGlobalKey.currentState!.reset();
                                      _clearAllFeilds();
                                      guestType = GuestType.external;
                                      _selectedDate = null;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'New booking added successfully')));
                                    }
                                  },
                                  child: Text(
                                    'Click to book',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: dummyOnbehalfData.length,
                itemBuilder: (context, index) {
                  final booking = dummyOnbehalfData[index];
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: BookedOnbehafCard(data: booking));
                },
              ),
            ],
          ),
        ));
  }
}
