import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/widgets/booking_request_list_item.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyBookingData.length,
        itemBuilder: (context, index) {
          final booking = dummyBookingData[index];

          return BookingRequestListItem(
            booking: booking,
            index: index,
            // delete: _showDeleteConformationDialog,
            // accept: _showAcceptConformationDialog
          );
        });
  }
}
