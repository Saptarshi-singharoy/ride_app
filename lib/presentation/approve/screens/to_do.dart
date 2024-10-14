import 'package:flutter/material.dart';
import 'package:ride_app/core/widgets/booked_item_card.dart';
import 'package:ride_app/data/dummies/dummy_booking_data.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyBookingData.length,
        itemBuilder: (context, index) {
          final booking = dummyBookingData[index];

          return Padding(
            padding: const EdgeInsets.all(8),
            child: BookedItemCard(booking: booking, forApprove: true
                // delete: _showDeleteConformationDialog,
                // accept: _showAcceptConformationDialog
                ),
          );
        });
  }
}
