import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/widgets/booked_item_card.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyBookingData.length,
      itemBuilder: (context, index) {
        final booking = dummyBookingData[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child:
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0, end: 1),
            child: Column(
              children: [
                BookedItemCard(booking: booking),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            builder: (context, value, child) {
              return Opacity(
                opacity: value ,
                child: Padding(
                  padding: EdgeInsets.only(top: 100 - value * 100),
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
