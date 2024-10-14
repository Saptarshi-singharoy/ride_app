import 'package:flutter/material.dart';

class CarDetailsState {
  final bool selectedSaturday;
  final bool selectedSunday;
  final bool hasSaturday;
  final bool hasSunday;
  final DateTime? selectedDate;
  final DateTime? selectedDateTill;
  final TimeOfDay? selectedTime;
  final TimeOfDay? selectedTimeTill;
  final String? selectRepeat;
  final String? selectedCarLocation;
  final String? selectedCarType;
  final int? numberOfCars;

  CarDetailsState({
    required this.selectedSaturday,
    required this.selectedSunday,
    required this.hasSaturday,
    required this.hasSunday,
    required this.selectedDate,
    required this.selectedDateTill,
    required this.selectedTime,
    required this.selectedTimeTill,
    required this.selectRepeat,
    required this.selectedCarLocation,
    required this.selectedCarType,
    required this.numberOfCars,
  });

  CarDetailsState copyWith({
    bool? selectedSaturday,
    bool? selectedSunday,
    bool? hasSaturday,
    bool? hasSunday,
    DateTime? selectedDate,
    DateTime? selectedDateTill,
    TimeOfDay? selectedTime,
    TimeOfDay? selectedTimeTill,
    String? selectRepeat,
    String? selectedCarLocation,
    String? selectedCarType,
    int? numberOfCars,
  }) {
    return CarDetailsState(
      selectedSaturday: selectedSaturday ?? this.selectedSaturday,
      selectedSunday: selectedSunday ?? this.selectedSunday,
      hasSaturday: hasSaturday ?? this.hasSaturday,
      hasSunday: hasSunday ?? this.hasSunday,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDateTill: selectedDateTill ?? this.selectedDateTill,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedTimeTill: selectedTimeTill ?? this.selectedTimeTill,
      selectRepeat: selectRepeat ?? this.selectRepeat,
      selectedCarLocation: selectedCarLocation ?? this.selectedCarLocation,
      selectedCarType: selectedCarType ?? this.selectedCarType,
      numberOfCars: numberOfCars ?? this.numberOfCars,
    );
  }
}
