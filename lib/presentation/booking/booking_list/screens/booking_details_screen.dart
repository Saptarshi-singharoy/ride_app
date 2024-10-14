import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ride_app/data/models/booking.model.dart';
import 'package:ride_app/utils/themes/themes.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              DetailHeader(data: "User Details"),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.grey[100],
                  elevation: 4,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Info(title: 'Name', info: 'Saptarshi Singha Roy'),
                        Info(title: 'Contact Number', info: '9876543210'),
                        Info(title: 'Department', info: 'Sales and Marketing'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DetailHeader(data: "Travel Details"),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.grey[100],
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
              const SizedBox(
                height: 20,
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: provideColorScheme(context).primary),
        ),
        Text(
          info.toString(),
          style: TextStyle(
              color: provideColorScheme(context).secondary,
              fontStyle: FontStyle.italic),
        ),
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
        color: Colors.grey[100],
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
  final String data;
  bool? editable;
  DetailHeader({required this.data, this.editable});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          if (editable != null)
            TextButton(onPressed: () {}, child: const Text('Edit'))
        ],
      ),
      Divider(),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
