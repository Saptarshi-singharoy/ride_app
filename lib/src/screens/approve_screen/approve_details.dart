import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/models/booking.model.dart';

class ApproveDetails extends StatefulWidget {
  final BookingModel booking;

  const ApproveDetails({super.key, required this.booking});

  @override
  State<ApproveDetails> createState() => _ApproveDetailsState();
}

class _ApproveDetailsState extends State<ApproveDetails> {
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

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("data"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.onTertiary),
                    onPressed: () {
                      // widget.accept(widget.booking);
                      _showAcceptConformationDialog(widget.booking);
                    },
                    child: const Row(
                      children: [Icon(Icons.check), Text('Accept')],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.inversePrimary),
                    onPressed: () {
                      // widget.delete(widget.booking);
                      _showDeleteConformationDialog(widget.booking);
                    },
                    child: const Row(
                      children: [Icon(Icons.close), Text('Reject')],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
