import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/models/booking.model.dart';
import 'package:ride_app/src/screens/approve_screen/approve_details.dart';

class BookingRequestListItem extends StatefulWidget {
  const BookingRequestListItem({
    super.key,
    required this.booking,
    required this.index,
    // required this.delete,
    // required this.accept,
  });

  final dynamic booking;
  final int index;
  // final Function(BookingModel) delete;
  // final Function(BookingModel) accept;

  @override
  State<BookingRequestListItem> createState() => _BookingRequestListItemState();
}

class _BookingRequestListItemState extends State<BookingRequestListItem> {
  final CheckedList = [];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return ApproveDetails(booking: widget.booking);
        }));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: colorScheme.tertiary,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.booking.reporting),
                  Text(widget.booking.release),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
