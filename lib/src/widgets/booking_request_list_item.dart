import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/models/booking.model.dart';

class BookingRequestListItem extends StatefulWidget {
  const BookingRequestListItem({
    super.key,
    required this.booking,
    required this.index,
    required this.delete,
    required this.accept,
  });

  final dynamic booking;
  final int index;
  final Function(BookingModel) delete;
  final Function(BookingModel) accept;

  @override
  State<BookingRequestListItem> createState() => _BookingRequestListItemState();
}

class _BookingRequestListItemState extends State<BookingRequestListItem> {
  final CheckedList = [];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.all(10),
      shadowColor: colorScheme.tertiary,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ListTile(
              key: ValueKey(widget.booking.id),
              onTap: () {
                print(widget.booking.id);
              },
              leading: Text((widget.index + 1).toString()),
              title: Text('Name ${widget.index}'),
              // contentPadding: EdgeInsets.all(10),
              subtitle: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.booking.pickup),
                    Text('to'),
                    Text(widget.booking.destination),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.onTertiary),
                    onPressed: () {
                      widget.accept(widget.booking);
                    },
                    child: const Row(
                      children: [Icon(Icons.check), Text('Accept')],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.inversePrimary),
                    onPressed: () {
                      widget.delete(widget.booking);
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
