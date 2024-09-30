import 'package:flutter/material.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/models/booking.model.dart';
import 'package:ride_app/src/screens/approve_screen/to_do.dart';
import 'package:ride_app/src/widgets/booking_request_list_item.dart';
// import 'package:ride_app/src/widgets/booking_request_card.dart';

class ApproveRequestScreen extends StatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  State<ApproveRequestScreen> createState() => _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends State<ApproveRequestScreen> {
  final CheckedList = [];

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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
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
              ToDo(),
              Text("Page 2"),
            ],
          ),
        ));
  }
}
