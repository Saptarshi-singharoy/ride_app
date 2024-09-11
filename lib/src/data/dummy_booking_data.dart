import 'package:ride_app/src/models/booking.model.dart';

final dummyBookingData = [
  BookingModel(
      pickup: 'Nabadwip',
      date: DateTime.now(),
      destination: 'Krishnanagar',
      purpose: 'Visit'),
  BookingModel(
      pickup: 'Madhyamgram',
      date: DateTime.now(),
      destination: 'Sodpur',
      purpose: 'college',
      status: Status.ACCEPTED),
      
  BookingModel(
      pickup: 'Krishnanagar',
      date: DateTime.now(),
      destination: 'Nabadwip',
      purpose: 'home',
      status: Status.REJECTED),
  BookingModel(
      pickup: 'Madhyamgram',
      date: DateTime.now(),
      destination: 'New Town',
      purpose: 'Office'),
];
