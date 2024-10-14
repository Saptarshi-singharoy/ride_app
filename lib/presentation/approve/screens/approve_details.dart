import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ride_app/data/dummies/dummy_booking_data.dart';
import 'package:ride_app/data/models/booking.model.dart';
import 'package:ride_app/presentation/approve/provider/approved/approved_provider.dart';
import 'package:ride_app/presentation/booking/booking_list/screens/booking_details_screen.dart';
import 'package:ride_app/presentation/booking/new_booking/screens/user_details.dart';
import 'package:ride_app/core/widgets/custom_button.dart';
import 'package:ride_app/utils/themes/themes.dart';

class ApproveDetails extends ConsumerStatefulWidget {
  final BookingModel booking;

  const ApproveDetails({super.key, required this.booking});

  @override
  ConsumerState<ApproveDetails> createState() => _ApproveDetailsState();
}

class _ApproveDetailsState extends ConsumerState<ApproveDetails> {
  void _showDeleteConformationDialog(BookingModel booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure to reject this request?'),
        content: TextField(
          decoration: InputDecoration(label: Text("Write  Comment...")),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop(false);
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  dummyBookingData.remove(booking);
                });
                Navigator.pop(context);
              },
              child: Text('Reject')),
        ],
      ),
    );
  }

  void _showAcceptConformationDialog(BookingModel booking, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure to accept this request?'),
        actions: [
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop(false);
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(approvedNotifierProvider.notifier)
                    .addToApproved(booking);
                // setState(() {
                dummyBookingData.remove(booking);
                // });
                Navigator.pop(context);
              },
              child: Text('Accept')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final approvedNotifier = ref.read(approvedNotifierProvider.notifier);

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      DetailHeader(
                        data: "User Details",
                        editable: true,
                      ),
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
                                Info(title: 'Name', info: 'Saptarshi'),
                                Info(
                                    title: 'Contact Number',
                                    info: '9876543210'),
                                Info(
                                    title: 'Department',
                                    info: 'Sales and Marketing'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DetailHeader(
                        data: "Travel Details",
                        editable: true,
                      ),
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
                                    info: widget.booking.locationOfTravel),
                                Info(
                                    title: 'Destination',
                                    info: widget.booking.destination),
                                Info(
                                    title: 'No of persons travelling',
                                    info: widget.booking.noOfPerson),
                                Info(title: 'Cost Center', info: 'Marketing'),
                                Info(
                                    title: 'Car Cost',
                                    info: widget.booking.costOfCar),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DetailHeader(
                        data: "Car Details",
                        editable: true,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CarDetailsCard(
                              booking: widget.booking,
                            ),
                            CarDetailsCard(
                              booking: widget.booking,
                            ),
                            CarDetailsCard(
                              booking: widget.booking,
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      onPressedFunction: () =>
                          _showAcceptConformationDialog(widget.booking, ref),
                      backgroundColor: Color.fromRGBO(73, 126, 116, 1),
                      content: "Accept",
                      icon: Icons.check),
                  CustomButton(
                    onPressedFunction: () =>
                        _showDeleteConformationDialog(widget.booking),
                    backgroundColor: Colors.red,
                    content: 'Reject',
                    icon: Icons.close,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
