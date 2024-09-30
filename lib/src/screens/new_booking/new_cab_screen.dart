import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ride_app/src/models/booking.model.dart';
import 'package:ride_app/src/widgets/date_time_picker.dart';
import 'package:ride_app/src/widgets/text_field_custom.dart';

enum GuestType { external, internal }

enum Departments { department1, department2, department3, department4 }

Map<String, double> CarTypes = {
  "Dzire (4+1)": 160,
  "Traveller(25+1)": 120,
  "Altis (4+1)": 280,
  "Crysta (5+1)": 240,
  "Honda City (4+1)": 220,
  "Mercedes (4+1)": 880,
  "Ertiga (5+1)": 300,
  "Winger (13+1)": 400,
  "Fortuner (5+1)": 570
};

List<String> carLocations = ["Same", "Different"];
List<String> requiredDays = ["Once", "Daily"];

enum TravelLocation { Local, Outstation }

class NewCabScreen extends StatefulWidget {
  const NewCabScreen({
    super.key,
  });

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
  DateTime? _selectedDateTill;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTimeTill;

  bool _hasSaturday = false;
  bool _hasSunday = false;
  bool selectedSunday = true;
  bool selectedSaturday = true;

  String? _selectedCarType;
  int? _numberOfCars = 1;

  String? _selectedCarLocation = carLocations[0];
  String? _selectRepeat = requiredDays[0];

  void _pickDate() async {
    DateTime now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: now,
        lastDate: DateTime.now().add(Duration(days: 10)),
        initialDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _pickDateTill() async {
    DateTime now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      // firstDate: now,
      firstDate: _selectedDate == null ? now : _selectedDate!,
      lastDate: _selectedDate == null
          ? now.add(Duration(days: 30))
          : _selectedDate!.add(Duration(days: 10)),
      initialDate: _selectedDate == null ? now : _selectedDate!,
    );
    setState(() {
      _selectedDateTill = pickedDate;
    });
  }

  void _pickTime() async {
    TimeOfDay now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: now,
        initialEntryMode: TimePickerEntryMode.dial);
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _pickTimeTill() async {
    TimeOfDay now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: now,
        initialEntryMode: TimePickerEntryMode.dial);
    if (pickedTime != null) {
      setState(() {
        _selectedTimeTill = pickedTime;
      });
    }
  }

  void _checkForWeekends(DateTime startDate, DateTime endDate) {
    // Reset the flags
    _hasSaturday = false;
    _hasSunday = false;

    DateTime current = startDate;

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (current.weekday == DateTime.saturday) {
        _hasSaturday = true; // Found a Saturday
      }
      if (current.weekday == DateTime.sunday) {
        _hasSunday = true; // Found a Sunday
      }
      current = current.add(Duration(days: 1)); // Move to the next day
    }
  }

  @override
  void dispose() {
    _fromController.dispose();
    _nameOfGuestController.dispose();
    _purposeController.dispose();
    _toController.dispose();
    super.dispose();
  }

  String _travelLocation = TravelLocation.Outstation.name;

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final feildTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.secondary);
    final headTextStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 20,
        );
    final indentColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.5);
    final dividerColor = Theme.of(context).colorScheme.primary;
    final sectionDivColor =
        Theme.of(context).colorScheme.primary.withOpacity(0.05);
    if (_selectedDate != null && _selectedDateTill != null) {
      _checkForWeekends(_selectedDate!, _selectedDateTill!);
    }
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20, 25, 20, keyboardSpace + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    color: sectionDivColor,
                    child: Column(
                      children: [
                        Text(
                          "User Details",
                          style: headTextStyle,
                        ),
                        Divider(
                          color: dividerColor,
                          height: 0,
                        ),
                        TextFeildCustom(
                            controller: _nameOfGuestController,
                            labelText: "Name of User"),
                        TextFormField(
                          keyboardType: TextInputType.phone,
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
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: indentColor), // Default color
                              ),
                              label: Text('Contact of User ',
                                  style: feildTextStyle)),
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
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: indentColor), // Default color
                              ),
                              label: Text(
                                "Department",
                                style: feildTextStyle,
                              )),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    color: sectionDivColor,
                    child: Column(
                      children: [
                        Text(
                          "Car Details",
                          style: headTextStyle,
                        ),
                        Divider(
                          color: dividerColor,
                          height: 5,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Car Reporting Date and Time :-",
                              style: feildTextStyle.copyWith(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DateTimePicker(
                                picker: _pickDate,
                                selectedValue: _selectedDate,
                                val: "Date"),
                            const SizedBox(
                              width: 50,
                            ),
                            DateTimePicker(
                                picker: _pickTime,
                                selectedValue: _selectedTime != null
                                    ? _selectedTime!.format(context)
                                    : 'Select a Time',
                                val: "Select a Time")
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Repeat: ",
                              style: feildTextStyle,
                            ),
                            Expanded(child: SizedBox()),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Once",
                                  style: feildTextStyle,
                                ),
                                Radio(
                                    value: "Once",
                                    groupValue: _selectRepeat,
                                    onChanged: (String? val) {
                                      setState(() {
                                        _selectRepeat = val;
                                      });
                                    })
                              ],
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text("Daily", style: feildTextStyle),
                                Radio(
                                    value: "Daily",
                                    groupValue: _selectRepeat,
                                    onChanged: (String? val) {
                                      setState(() {
                                        _selectRepeat = val;
                                      });
                                    })
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (_hasSunday && _selectRepeat == 'Daily')
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    "Exclude Sunday",
                                    style: feildTextStyle,
                                  ),
                                  Checkbox(
                                      value: selectedSunday,
                                      onChanged: (val) {
                                        setState(() {
                                          selectedSunday = !selectedSunday;
                                        });
                                      }),
                                ],
                              ),
                            if (_hasSaturday && _selectRepeat == 'Daily')
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    "Exclude Saturday",
                                    style: feildTextStyle,
                                  ),
                                  Checkbox(
                                      value: selectedSaturday,
                                      onChanged: (val) {
                                        setState(() {
                                          selectedSaturday = !selectedSaturday;
                                        });
                                      }),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Car Required till Date and Time :-",
                              style: feildTextStyle.copyWith(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DateTimePicker(
                                picker: _pickDateTill,
                                selectedValue: _selectedDateTill,
                                val: "Date"),
                            const SizedBox(
                              width: 50,
                            ),
                            DateTimePicker(
                                picker: _pickTimeTill,
                                selectedValue: _selectedTimeTill != null
                                    ? _selectedTimeTill!.format(context)
                                    : 'Select a Time',
                                val: "Time")
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'this feild is required';
                                  }
                                  return null;
                                },
                                items: CarTypes.keys.map((g) {
                                  return DropdownMenuItem(
                                    value: g,
                                    child: Text(g),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCarType = value;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: indentColor), // Default color
                                    ),
                                    label: Text("Car Type",
                                        style: feildTextStyle)),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null || value == 0) {
                                    return 'this feild is required';
                                  }
                                  return null;
                                },
                                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((g) {
                                  return DropdownMenuItem(
                                    value: g,
                                    child: Text(g.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _numberOfCars = value;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: indentColor), // Default color
                                    ),
                                    label: Text("No. of Car",
                                        style: feildTextStyle)),
                              ),
                            ),
                          ],
                        ),
                        if (CarTypes[_selectedCarType] != null &&
                            _numberOfCars != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Text("Cost of Car: ",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary)),
                                Text(
                                    (CarTypes[_selectedCarType]! *
                                            _numberOfCars!)
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary)),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Locations: ",
                              style: feildTextStyle,
                            ),
                            Expanded(child: SizedBox()),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Same",
                                  style: feildTextStyle,
                                ),
                                Radio(
                                    value: "Same",
                                    groupValue: _selectedCarLocation,
                                    onChanged: (String? val) {
                                      setState(() {
                                        _selectedCarLocation = val;
                                      });
                                    })
                              ],
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text("Different", style: feildTextStyle),
                                Radio(
                                    value: "Different",
                                    groupValue: _selectedCarLocation,
                                    onChanged: (String? val) {
                                      setState(() {
                                        _selectedCarLocation = val;
                                      });
                                    })
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
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
                                borderSide: BorderSide(
                                    color: indentColor), // Default color
                              ),
                              label: Text(
                                  "Location of travel (Local / Outstation)",
                                  style: feildTextStyle)),
                        ),
                        TextFeildCustom(
                            controller: _extraFeild1, labelText: "Destination"),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.parse(value) > 10) {
                              return 'this feild is required';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          controller: _extraFeild4,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: indentColor), // Default color
                              ),
                              label: Text('Number of person travelling',
                                  style: feildTextStyle)),
                        ),
                      ],
                    ),
                  ),
                  _selectedCarLocation == "Same"
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          color: sectionDivColor,
                          child: Column(
                            children: [
                              Text(
                                "Car Details",
                                style: headTextStyle,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'this feild is required';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                controller: _extraFeild4,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: indentColor), // Default color
                                    ),
                                    label: Text('Address of reporting ',
                                        style: feildTextStyle)),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'this feild is required';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                controller: _extraFeild4,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: indentColor), // Default color
                                    ),
                                    label: Text('Address of release ',
                                        style: feildTextStyle)),
                              ),
                              TextFeildCustom(
                                  controller: _extraFeild1,
                                  labelText: 'Contact name '),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'this feild is required';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                controller: _extraFeild4,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: indentColor), // Default color
                                    ),
                                    label: Text('Contact number ',
                                        style: feildTextStyle)),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _numberOfCars,
                          itemBuilder: (ctx, i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              color: sectionDivColor,
                              child: Column(
                                children: [
                                  Text(
                                    "Car no. ${i + 1} details",
                                    style: headTextStyle,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'this feild is required';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    controller: _extraFeild4,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  indentColor), // Default color
                                        ),
                                        label: Text('Address of reporting ',
                                            style: feildTextStyle)),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'this feild is required';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    controller: _extraFeild4,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  indentColor), // Default color
                                        ),
                                        label: Text('Address of release ',
                                            style: feildTextStyle)),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          int.parse(value) > 10) {
                                        return 'this feild is required';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    controller: _extraFeild4,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  indentColor), // Default color
                                        ),
                                        label: Text(
                                            'Number of person travelling',
                                            style: feildTextStyle)),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'this feild is required';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    controller: _extraFeild4,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  indentColor), // Default color
                                        ),
                                        label: Text('Contact number of user ',
                                            style: feildTextStyle)),
                                  ),
                                ],
                              ),
                            );
                          }),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Others",
                    style: headTextStyle,
                  ),
                  Divider(
                    color: dividerColor,
                    height: 5,
                  ),
                  TextFormField(
                    initialValue: "const center 123",
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this feild is required';
                      }
                      return null;
                    },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: indentColor), // Default color
                        ),
                        label: Text('Cost Centre', style: feildTextStyle)),
                  ),
                  TextFeildCustom(
                      controller: _extraFeild1,
                      labelText: "Event Code(if any)"),
                  TextFeildCustom(
                      controller: _purposeController, labelText: "Purpose"),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer),
                        onPressed: () {},
                        child: Text('Click to request')),
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
