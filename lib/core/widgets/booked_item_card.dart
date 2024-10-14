import 'package:flutter/material.dart';
import 'package:ride_app/core/widgets/approval_status_modal.dart';
import 'package:ride_app/data/models/booking.model.dart';
import 'package:ride_app/presentation/approve/screens/approve_details.dart';
import 'package:ride_app/presentation/booking/booking_list/screens/booking_details_screen.dart';
import 'package:ride_app/utils/themes/themes.dart';

class BookedItemCard extends StatefulWidget {
  BookedItemCard(
      {super.key, required this.booking, this.forApprove, this.tapDisabled});

  final BookingModel booking;
  bool? forApprove;
  bool? tapDisabled;

  @override
  State<BookedItemCard> createState() => _BookedItemCardState();
}

class _BookedItemCardState extends State<BookedItemCard> {
  Color? mainColor = Colors.red[900];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      color: Colors.grey[100],
      shadowColor: colorScheme.tertiary,
      child: InkWell(
        onTap: () {
          if (widget.tapDisabled != true) {
            widget.forApprove == true
                ? Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return ApproveDetails(booking: widget.booking);
                  }))
                : Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return BookingDetailsScreen(booking: widget.booking);
                  }));
          }
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
                    'For ${widget.booking.formattedRequiredDate} ${widget.booking.formattedReportTime} ',
                    style: textTheme.bodySmall!.copyWith(
                        color: colorScheme.secondary,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Till ${widget.booking.formattedReleaseDate} ${widget.booking.formattedReleaseTime} ',
                    style: textTheme.bodySmall!.copyWith(
                        color: colorScheme.secondary,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 15, color: mainColor),
                          Text(
                            widget.booking.reporting,
                            style: textTheme.bodyMedium!.copyWith(
                                color: mainColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // Icon(Icons.east_rounded),
                    // Icon(Icons.keyboard_double_arrow_right,
                    //     color: colorScheme.primary),
                    Flexible(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 15, color: mainColor),
                          Text(
                            widget.booking.release,
                            style: textTheme.bodyMedium!.copyWith(
                                color: mainColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Purpose: ${widget.booking.purpose}',
                        style: textTheme.bodySmall!.copyWith(
                            color: colorScheme.secondary,
                            fontSize: 15,
                            fontStyle: FontStyle.italic)),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("gfddfggfdgfgffg");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return ApprovalStatusModal();
                            return Dialog(
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ApprovalStatusModal(),
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.booking.status == Status.PENDING
                            ? Colors.blue
                            : widget.booking.status == Status.ACCEPTED
                                ? Colors.green
                                : Colors.red,
                      ),
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                                widget.booking.status == Status.ACCEPTED
                                    ? Icons.check
                                    : widget.booking.status == Status.REJECTED
                                        ? Icons.close
                                        : Icons.access_time,
                                size: 15,
                                color: Colors.white),
                            Text(
                              widget.booking.status.name,
                              style: textTheme.bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
