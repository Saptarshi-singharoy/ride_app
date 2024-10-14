import 'package:ride_app/data/models/booking.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'approved_provider.g.dart';

@riverpod
class ApprovedNotifier extends _$ApprovedNotifier {
  @override
  List<BookingModel> build() {
    return [
      // BookingModel(
      //   reporting: 'sadsadsadsa',
      //   release: 'wqqweewqqwe',
      //   requiredDate: DateTime.now(),
      //   releaseDate: DateTime.now(),
      //   destination: 'Krishnanagar',
      //   purpose: 'Visit',
      //   noOfCars: 1,
      //   noOfPerson: 2,
      //   costOfCar: 123,
      //   locationOfTravel: 'Local',
      //   userContactNo: '98785646546',
      //   carType: 'Dzire',
      // )
    ];
  }

  void addToApproved(BookingModel booking) {
    state = [...state, booking];
    print('UPDATED $state');
  }
}
