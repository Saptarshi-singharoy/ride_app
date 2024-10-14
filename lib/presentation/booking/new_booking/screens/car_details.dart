import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/widgets/date_time_picker.dart';
import 'package:ride_app/presentation/booking/new_booking/provider/car_details_provider.dart';
import 'package:ride_app/utils/themes/themes.dart';

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

class CarDetails extends ConsumerWidget {
  final void Function(WidgetRef ref) pickDate;
  final void Function(WidgetRef ref) pickDateTill;
  final void Function(WidgetRef ref) pickTime;
  final void Function(WidgetRef ref) pickTimeTill;

  void _checkForWeekends(DateTime startDate, DateTime endDate, WidgetRef ref) {
    // Reset the flags
    // _hasSaturday = false;
    // _hasSunday = false;

    DateTime current = startDate;

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (current.weekday == DateTime.saturday) {
        ref
            .read(carDetailsNotifierProvider.notifier)
            .toggleSaturdayTrue(); // Found a Saturday
      }
      if (current.weekday == DateTime.sunday) {
        ref
            .read(carDetailsNotifierProvider.notifier)
            .toggleSundayTrue(); // Found a Sunday
      }
      current = current.add(Duration(days: 1)); // Move to the next day
    }
  }

  WidgetRef ref;

  CarDetails(
      {super.key,
      required this.pickDate,
      required this.pickDateTill,
      required this.pickTime,
      required this.pickTimeTill,
      required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final carDetails = ref.watch(carDetailsNotifierProvider);
    final carDetailsNotifier = ref.read(carDetailsNotifierProvider.notifier);

    if (carDetails.selectedDate != null &&
        carDetails.selectedDateTill != null) {
      _checkForWeekends(
          carDetails.selectedDate!, carDetails.selectedDateTill!, ref);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: sectionDivColor,
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                print(carDetails.hasSaturday);
                print(carDetails.hasSunday);
              },
              child: Text("data")),
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
                style: feildTextStyle.copyWith(fontWeight: FontWeight.bold)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimePicker(
                  picker: () => pickDate(ref),
                  selectedValue: carDetails.selectedDate,
                  val: "Date"),
              const SizedBox(
                width: 50,
              ),
              DateTimePicker(
                  picker: () => pickTime(ref),
                  selectedValue: carDetails.selectedTime != null
                      ? carDetails.selectedTime!.format(context)
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
                      groupValue: carDetails.selectRepeat,
                      onChanged: (String? val) =>
                          carDetailsNotifier.setRepeat(val!))
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Daily", style: feildTextStyle),
                  Radio(
                      groupValue: carDetails.selectRepeat,
                      value: "Daily",
                      onChanged: (String? val) =>
                          carDetailsNotifier.setRepeat(val!))
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (carDetails.hasSunday && carDetails.selectRepeat == 'Daily')
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Exclude Sunday",
                      style: feildTextStyle,
                    ),
                    Checkbox(
                        value: carDetails.selectedSunday,
                        onChanged: (val) => carDetailsNotifier.toggleSunday()),
                  ],
                ),
              if (carDetails.hasSaturday && carDetails.selectRepeat == 'Daily')
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Exclude Saturday",
                      style: feildTextStyle,
                    ),
                    Checkbox(
                        value: carDetails.selectedSaturday,
                        onChanged: (val) =>
                            carDetailsNotifier.toggleSaturday()),
                  ],
                ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
                carDetails.selectRepeat == 'Daily'
                    ? "Repeat Till Date"
                    : "Car Required till Date and Time :-",
                style: feildTextStyle.copyWith(fontWeight: FontWeight.bold)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimePicker(
                  picker: () => pickDateTill(ref),
                  selectedValue: carDetails.selectedDateTill,
                  val: "Date"),
              const SizedBox(
                width: 50,
              ),
              carDetails.selectRepeat == 'Once'
                  ? DateTimePicker(
                      picker: () => pickTimeTill(ref),
                      selectedValue: carDetails.selectedTimeTill != null
                          ? carDetails.selectedTimeTill!.format(context)
                          : 'Select a Time',
                      val: "Time")
                  : SizedBox.shrink()
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
                      carDetailsNotifier.setCarType(value);
                    }
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: indentColor), // Default color
                      ),
                      label: Text("Car Type", style: feildTextStyle)),
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
                      carDetailsNotifier.setNumberOfCars(value);
                    }
                  },
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: indentColor), // Default color
                      ),
                      label: Text("No. of Car", style: feildTextStyle)),
                ),
              ),
            ],
          ),
          if (CarTypes[carDetails.selectedCarType] != null &&
              carDetails.numberOfCars != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Text("Cost of Car: ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                  Text(
                      (CarTypes[carDetails.selectedCarType]! *
                              carDetails.numberOfCars!)
                          .toString(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
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
                      groupValue: carDetails.selectedCarLocation,
                      onChanged: (String? val) =>
                          carDetailsNotifier.setCarLocation(val!))
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Different", style: feildTextStyle),
                  Radio(
                      value: "Different",
                      groupValue: carDetails.selectedCarLocation,
                      onChanged: (String? val) =>
                          carDetailsNotifier.setCarLocation(val!))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
