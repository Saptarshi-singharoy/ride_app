import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/models/booking.model.dart';
import 'package:ride_app/src/widgets/booking_request_list_item.dart';
// import 'package:ride_app/src/widgets/booking_request_card.dart';

class ApproveRequestScreen extends StatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  State<ApproveRequestScreen> createState() => _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends State<ApproveRequestScreen> {
  final CheckedList = [];

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

  void _showAcceptConformationDialog(BookingModel booking) {
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
                setState(() {
                  dummyBookingData.remove(booking);
                });
                Navigator.pop(context);
              },
              child: Text('Accept')),
        ],
      ),
    );
  }

  void _delete(booking) {
    setState(() {
      dummyBookingData.remove(booking);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = Theme.of(context).textTheme;
    // ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const TabBar(
              tabs: [
                Tab(
                  text: "To Do",
                ),
                Tab(
                  text: "Approve",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: dummyBookingData.length,
                itemBuilder: (context, index) {
                  final booking = dummyBookingData[index];
                  return BookingRequestListItem(
                      booking: booking,
                      index: index,
                      delete: _showDeleteConformationDialog,
                      accept: _showAcceptConformationDialog);
                },
              ),
              Text("Page 2"),
            ],
          ),
        ));
  }
}
