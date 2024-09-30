import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

DateFormat formatter = DateFormat.yMd();

const uid = Uuid();

enum Status { ACCEPTED, REJECTED, PENDING }

class BookingModel {
  BookingModel(
      {required this.reporting,
      required this.release,
      required this.requiredDate,
      required this.releaseDate,
      required this.costOfCar,
      required this.noOfCars,
      required this.locationOfTravel,
      required this.noOfPerson,
      required this.userContactNo,
      required this.carType,
      required this.destination,
      required this.purpose,
      this.status = Status.PENDING})
      : id = uid.v8();

  final String id;
  final String reporting;
  final String release;
  final DateTime requiredDate;
  final DateTime releaseDate;
  final String purpose;
  final Status status;
  final String carType;
  final double costOfCar;
  final int noOfCars;
  final String locationOfTravel;
  final String destination;
  final int noOfPerson;
  final String userContactNo;

  String get formattedDate {
    return formatter.format(requiredDate);
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'reporting': String reporting,
        'release': String release,
        'destination': String destination,
        'requiredDate': DateTime requiredDate,
        'releaseDate': DateTime releaseDate,
        'purpose': String purpose,
        'carType': String carType,
        'costOfCar': double costOfCar,
        'noOfCars': int noOfCars,
        'locationOfTravel': String locationOfTravel,
        'noOfPerson': int noOfPerson,
        'userContactNo': String userContactNo
      } =>
        BookingModel(
            destination: destination,
            purpose: purpose,
            reporting: reporting,
            release: release,
            requiredDate: requiredDate,
            releaseDate: releaseDate,
            carType: carType,
            costOfCar: costOfCar,
            noOfCars: noOfCars,
            locationOfTravel: locationOfTravel,
            noOfPerson: noOfPerson,
            userContactNo: userContactNo),
      _ => throw FormatException('wrong format')
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporting': reporting,
      'release': release,
      'destination': destination,
      'requiredDate': requiredDate,
      'releaseDate': releaseDate,
      'purpose': purpose,
      'carType': carType,
      'costOfCar': costOfCar,
      'noOfCars': noOfCars,
      'locationOfTravel': locationOfTravel,
      'noOfPerson': noOfPerson,
      'userContactNo': userContactNo,
      'status': status.name
    };
  }
}
