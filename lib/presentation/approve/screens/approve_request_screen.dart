import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/data/dummies/dummy_booking_data.dart';
import 'package:ride_app/data/models/booking.model.dart';
import 'package:ride_app/presentation/approve/provider/approved/approved_provider.dart';
import 'package:ride_app/presentation/approve/screens/approved.dart';
import 'package:ride_app/presentation/approve/screens/to_do.dart';
// import 'package:ride_app/core/widgets/booking_request_list_item.dart';
// import 'package:ride_app/src/widgets/booking_request_card.dart';

class ApproveRequestScreen extends ConsumerStatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  ConsumerState<ApproveRequestScreen> createState() =>
      _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends ConsumerState<ApproveRequestScreen> {
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
    final approvedList = ref.watch(approvedNotifierProvider);
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
                  text: "Approved",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ToDo(),
              approvedList.isEmpty
                  ? Center(child: Text('Nothing here'))
                  : Approved(),
            ],
          ),
        ));
  }
}
