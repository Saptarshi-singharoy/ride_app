import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/presentation/approve/provider/approved/approved_provider.dart';
import 'package:ride_app/presentation/booking/new_booking/provider/car_details_provider.dart';
import 'package:ride_app/presentation/booking/new_booking/screens/car_details.dart';
import 'package:ride_app/presentation/booking/new_booking/screens/travel_details.dart';
import 'package:ride_app/presentation/booking/new_booking/screens/user_details.dart';
import 'package:ride_app/core/widgets/text_field_custom.dart';
import 'package:ride_app/utils/themes/themes.dart';

enum GuestType { external, internal }

List<String> carLocations = ["Same", "Different"];
List<String> requiredDays = ["Once", "Daily"];

class NewCabScreen extends ConsumerStatefulWidget {
  const NewCabScreen({
    super.key,
  });

  @override
  ConsumerState<NewCabScreen> createState() => _NewCabScreenState();
}

class _NewCabScreenState extends ConsumerState<NewCabScreen> {
  final _formGlobalKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _userContactNumberController = TextEditingController();
  Departments? _selectedDepartment;

  void _onDepartmentChanged(Departments? department) {
    setState(() {
      _selectedDepartment = department;
    });
    print('Selected Department: ${_selectedDepartment?.name}');
  }

  final _destinationController = TextEditingController();
  final _numberOfPersonTravellingController = TextEditingController();

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _nameOfGuestController = TextEditingController();
  final _purposeController = TextEditingController();

  final _carAddressOfReporting = TextEditingController();
  final _carAddressOfRelease = TextEditingController();
  final _contactName = TextEditingController();
  final _contactNumber = TextEditingController();

  // DateTime? _selectedDate;
  // DateTime? _selectedDateTill;
  // TimeOfDay? _selectedTime;
  // TimeOfDay? _selectedTimeTill;

  // bool _hasSaturday = false;
  // bool _hasSunday = false;
  // bool selectedSunday = true;
  // bool selectedSaturday = true;

  // String? _selectedCarType;
  // int? _numberOfCars = 1;

  // String? _selectedCarLocation = carLocations[0];
  // String? _selectRepeat = requiredDays[0];

  void _pickDate(WidgetRef ref) async {
    DateTime now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: now,
        lastDate: DateTime.now().add(Duration(days: 10)),
        initialDate: now);
    ref.read(carDetailsNotifierProvider.notifier).setDate(pickedDate);
  }

  void _pickDateTill(WidgetRef ref) async {
    DateTime now = DateTime.now();
    DateTime? selectedDate = ref.watch(carDetailsNotifierProvider).selectedDate;
    final pickedDate = await showDatePicker(
      context: context,
      // firstDate: now,
      firstDate: selectedDate == null ? now : selectedDate!,
      lastDate: selectedDate == null
          ? now.add(Duration(days: 30))
          : selectedDate!.add(Duration(days: 10)),
      initialDate: selectedDate == null ? now : selectedDate!,
    );
    // setState(() {
    //   _selectedDateTill = pickedDate;
    // });
    ref.read(carDetailsNotifierProvider.notifier).setDateTill(pickedDate);
  }

  void _pickTime(WidgetRef ref) async {
    TimeOfDay now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: now,
        initialEntryMode: TimePickerEntryMode.dial);
    if (pickedTime != null) {
      ref.read(carDetailsNotifierProvider.notifier).setTime(pickedTime);
    }
  }

  void _pickTimeTill(WidgetRef ref) async {
    TimeOfDay now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: now,
        initialEntryMode: TimePickerEntryMode.dial);
    if (pickedTime != null) {
      ref.read(carDetailsNotifierProvider.notifier).setTimeTill(pickedTime);
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

  @override
  Widget build(BuildContext context) {
    final carDetails = ref.watch(carDetailsNotifierProvider);

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final feildTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.primary);
    final headTextStyle = provideTextTheme(context).bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    final indentColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.5);
    final dividerColor = Theme.of(context).colorScheme.primary;
    final sectionDivColor = Colors.grey[50];

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
                  UserDetailsForm(controllers: [
                    _userNameController,
                    _userContactNumberController
                  ], changeDepartmentFunction: _onDepartmentChanged),
                  CarDetails(
                      pickDate: _pickDate,
                      pickDateTill: _pickDateTill,
                      pickTime: _pickTime,
                      pickTimeTill: _pickTimeTill,
                      ref: ref),
                  const SizedBox(
                    height: 20,
                  ),
                  TravelDetails(controllers: [
                    _destinationController,
                    _numberOfPersonTravellingController
                  ]),
                  carDetails.selectedCarLocation == "Same"
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
                                controller: _carAddressOfReporting,
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
                                controller: _carAddressOfRelease,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: indentColor), // Default color
                                    ),
                                    label: Text('Address of release ',
                                        style: feildTextStyle)),
                              ),
                              TextFeildCustom(
                                  controller: _contactName,
                                  labelText: 'Contact name '),
                              TextFeildCustom(
                                controller: _contactNumber,
                                labelText: 'Contact number',
                                inputType: TextInputType.phone,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: carDetails.numberOfCars,
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
                                    controller: _carAddressOfReporting,
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
                                    controller: _carAddressOfRelease,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  indentColor), // Default color
                                        ),
                                        label: Text('Address of release ',
                                            style: feildTextStyle)),
                                  ),
                                  TextFeildCustom(
                                      controller: _contactName,
                                      labelText: 'Contact name'),
                                  TextFeildCustom(
                                    controller: _contactNumber,
                                    labelText: 'Contact number',
                                    inputType: TextInputType.phone,
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
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value == 0) {
                        return 'this feild is required';
                      }
                      return null;
                    },
                    items: ['Center 1', 'Center 2', 'Center 3'].map((g) {
                      return DropdownMenuItem(
                        value: g,
                        child: Text(g),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: indentColor), // Default color
                        ),
                        label: Text("Cost Center", style: feildTextStyle)),
                  ),
                  TextFeildCustom(
                      controller: _contactNumber,
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
                        onPressed: () {
                          // print('HELLO::::');
                          print(carDetails.selectedDate);
                          print(carDetails.selectedDateTill);
                          print(carDetails.selectedTime);
                          print(carDetails.selectedTimeTill);
                          print(carDetails.selectedSunday);
                          print(carDetails.selectedSaturday);
                          print(carDetails.hasSaturday);
                          print(carDetails.hasSunday);
                          print(carDetails.numberOfCars);
                          print(carDetails.selectedCarLocation);
                          print(carDetails.selectRepeat);
                          print(carDetails.selectedCarType);
                        },
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
