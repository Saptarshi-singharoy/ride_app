import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ride_app/src/models/booking.model.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              DetailHeader(data: "User Details"),
              const SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Info(title: 'Name', info: 'Saptarshi'),
                        Info(title: 'Contact Number', info: '9876543210'),
                        Info(title: 'Department', info: 'Sales and Marketing'),
                      ],
                    ),
                  ),
                ),
              ),
              DetailHeader(data: "Travel Details"),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Info(
                            title: 'Reporting Date and Time',
                            info:
                                '${formatter.format(DateTime.now())} ${DateFormat('hh:mm a').format(DateTime.now())}'),
                        Info(
                            title: 'Releasing Date and Time',
                            info:
                                '${formatter.format(DateTime.now())} ${DateFormat('hh:mm a').format(DateTime.now())}'),
                        Info(
                            title: 'Location Type',
                            info: booking.locationOfTravel),
                        Info(title: 'Destination', info: booking.destination),
                        Info(
                            title: 'No of persons travelling',
                            info: booking.noOfPerson),
                        Info(title: 'Cost Center', info: 'Marketing'),
                        Info(title: 'Car Cost', info: booking.costOfCar),
                      ],
                    ),
                  ),
                ),
              ),
              DetailHeader(data: "Car Details"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CarDetailsCard(
                      booking: booking,
                    ),
                    CarDetailsCard(
                      booking: booking,
                    ),
                    CarDetailsCard(
                      booking: booking,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key, required this.title, required this.info});

  final dynamic title;
  final dynamic info;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          '$title: ',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(info.toString()),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class CarDetailsCard extends StatelessWidget {
  CarDetailsCard({super.key, required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Info(title: 'Address of reporting', info: booking.reporting),
              Info(title: 'Address of release', info: booking.release),
              Info(title: 'Contact Name', info: 'Saptarshi'),
              Info(title: 'Contact Number', info: booking.userContactNo),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailHeader extends StatelessWidget {
  DetailHeader({required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        data,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold),
      ),
      Divider(),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
