import 'package:flutter/material.dart';
import 'package:ride_app/presentation/booking/new_booking/provider/car_details/car_details_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'car_details_provider.g.dart'; // Required for code generation

@riverpod
class CarDetailsNotifier extends _$CarDetailsNotifier {
  @override
  CarDetailsState build() {
    // Initial state
    return CarDetailsState(
      selectedSaturday: false,
      selectedSunday: false,
      hasSaturday: true,
      hasSunday: true,
      selectedDate: null,
      selectedDateTill: null,
      selectedTime: null,
      selectedTimeTill: null,
      selectRepeat: "Once",
      selectedCarLocation: "Same",
      selectedCarType: "Dzire (4+1)",
      numberOfCars: 1,
    );
  }

  void setDate(DateTime? date) {
    state = state.copyWith(selectedDate: date);
  }

  void setDateTill(DateTime? dateTill) {
    state = state.copyWith(selectedDateTill: dateTill);
  }

  void setTime(TimeOfDay? time) {
    state = state.copyWith(selectedTime: time);
  }

  void setTimeTill(TimeOfDay? timeTill) {
    state = state.copyWith(selectedTimeTill: timeTill);
  }

  void toggleSaturday() {
    state = state.copyWith(selectedSaturday: !state.selectedSaturday);
  }

  void toggleSaturdayTrue() {
    state = state.copyWith(selectedSaturday: false);
  }

  void toggleSunday() {
    state = state.copyWith(selectedSunday: !state.selectedSunday);
  }

  void toggleSundayTrue() {
    state = state.copyWith(selectedSunday: false);
  }

  void setRepeat(String repeat) {
    state = state.copyWith(selectRepeat: repeat);
  }

  void setCarLocation(String location) {
    state = state.copyWith(selectedCarLocation: location);
  }

  void setCarType(String carType) {
    state = state.copyWith(selectedCarType: carType);
  }

  void setNumberOfCars(int number) {
    state = state.copyWith(numberOfCars: number);
  }
}
