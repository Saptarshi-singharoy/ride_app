import 'package:flutter/material.dart';
import 'package:ride_app/src/models/booking.model.dart';
import 'package:ride_app/src/screens/booking_list/booking_details_screen.dart';

class BookedItemCard extends StatefulWidget {
  const BookedItemCard({super.key, required this.booking});

  final BookingModel booking;

  @override
  State<BookedItemCard> createState() => _BookedItemCardState();
}

class _BookedItemCardState extends State<BookedItemCard> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      shadowColor: colorScheme.tertiary,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return BookingDetailsScreen(booking: widget.booking);
          }));
        },
        splashColor: colorScheme.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking Id: ${widget.booking.id.substring(14, 23)}',
                    style: textTheme.bodySmall!
                        .copyWith(color: colorScheme.secondary),
                  ),
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                            widget.booking.status == Status.ACCEPTED
                                ? Icons.check
                                : widget.booking.status == Status.REJECTED
                                    ? Icons.close
                                    : Icons.access_time,
                            size: 15,
                            color: widget.booking.status == Status.PENDING
                                ? Colors.blue
                                : widget.booking.status == Status.ACCEPTED
                                    ? Colors.green
                                    : Colors.red),
                        Text(
                          widget.booking.status.name,
                          style: textTheme.bodySmall!.copyWith(
                              color: widget.booking.status == Status.PENDING
                                  ? Colors.blue
                                  : widget.booking.status == Status.ACCEPTED
                                      ? Colors.green
                                      : Colors.red),
                        ),
                      ])
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 15, color: Colors.red),
                          Text(
                            widget.booking.reporting,
                            style: textTheme.bodyLarge!.copyWith(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // Icon(Icons.east_rounded),
                    Icon(Icons.multiple_stop, color: colorScheme.primary),
                    Flexible(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 15, color: Colors.red),
                          Text(
                            widget.booking.destination,
                            style: textTheme.bodyLarge!.copyWith(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Booked for: ${widget.booking.formattedDate}',
                style:
                    textTheme.bodySmall!.copyWith(color: colorScheme.secondary),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Purpose: ${widget.booking.purpose}',
                  style: textTheme.bodySmall!
                      .copyWith(color: colorScheme.secondary)),
            ],
          ),
        ),
      ),
    );
  }
}
