import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

DateFormat formatter = DateFormat.yMd();

const uid = Uuid();

enum Status {
    ACCEPTED,
    REJECTED,
    PENDING
}

class BookingModel {

   BookingModel({
    required this.pickup,
    required this.date,
    required this.destination,
    required this.purpose,
    this.status = Status.PENDING
  }) : id = uid.v8();

  final String id;
  final String pickup;
  final String destination;
  final DateTime date;
  final String purpose;
  final Status status;

  String get formattedDate {
    return formatter.format(date);
  }

  factory BookingModel.fromJson(Map<String, dynamic> json){
    return switch (json) {
      {
        'id': String id,
        'pickup': String pickup,
        'destination' : String destination,
        'date': DateTime date,
        'purpose': String purpose,
        'status': String status
      } => 
      BookingModel(pickup: pickup, date: date, destination: destination, purpose: purpose),
      _ => throw FormatException('wrong format') 
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
        'pickup': pickup,
        'destination' :  destination,
        'date':  date,
        'purpose':  purpose,
        'status':  status

    };
  }
}