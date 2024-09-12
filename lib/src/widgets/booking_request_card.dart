import 'package:flutter/material.dart';
import 'package:ride_app/src/models/booking.model.dart';

class BookingRequestCard extends StatefulWidget {
  const BookingRequestCard(
      {super.key, required this.booking, required this.deleteFunc});

  final BookingModel booking;
  final Function() deleteFunc;

  @override
  State<BookingRequestCard> createState() => _BookingRequestCardState();
}

class _BookingRequestCardState extends State<BookingRequestCard> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Name here...'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          size: 15, color: colorScheme.primary),
                      Text(
                        widget.booking.pickup,
                        style: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold),
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
                      Icon(Icons.location_on,
                          size: 15, color: colorScheme.primary),
                      Text(
                        widget.booking.destination,
                        style: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.onTertiary),
                    onPressed: () {},
                    child: const Row(
                      children: [Icon(Icons.check), Text('Accept')],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.inversePrimary),
                    onPressed: () {},
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
