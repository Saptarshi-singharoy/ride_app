import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ride_app/src/data/dummy_booking_data.dart';
import 'package:ride_app/src/models/booking.model.dart';
// import 'package:ride_app/src/widgets/booking_request_card.dart';

class ApproveRequestScreen extends StatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  State<ApproveRequestScreen> createState() => _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends State<ApproveRequestScreen> {
  final CheckedList = [];

  void _showConformationDialog(BookingModel booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure to reject this request?'),
        content: TextField(
          decoration: InputDecoration(label: Text("Write  Comment...")),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop(false);
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  dummyBookingData.remove(booking);
                });
                Navigator.pop(context);
              },
              child: Text('Reject')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
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
              ListView.builder(
                itemCount: dummyBookingData.length,
                itemBuilder: (context, index) {
                  final booking = dummyBookingData[index];
                  return Slidable(
                    key: ValueKey(booking.id),
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            print("ACCEPT IT...");
                            dummyBookingData.remove(booking);
                          },
                          label: "Accept",
                          icon: Icons.check,
                          backgroundColor:
                              const Color.fromARGB(255, 163, 213, 165),
                        )
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _showConformationDialog(booking);
                          },
                          label: "Reject",
                          icon: Icons.close,
                          backgroundColor: colorScheme.inversePrimary,
                        )
                      ],
                    ),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shadowColor: colorScheme.tertiary,
                      child: ListTile(
                        key: ValueKey(booking.id),
                        // tileColor: colorScheme.primary.withOpacity(0.2),
                        onTap: () {
                          print(booking.id);
                        },
                        leading: Text((index + 1).toString()),
                        title: Text('Name $index'),
                        // contentPadding: EdgeInsets.all(10),
                        subtitle: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(booking.pickup),
                              Text('to'),
                              Text(booking.destination),
                            ],
                          ),
                        ),
                        trailing: Checkbox(
                          onChanged: (val) {
                            setState(() {
                              if (!CheckedList.contains(booking)) {
                                CheckedList.add(booking);
                              } else {
                                CheckedList.remove(booking);
                              }
                            });
                          },
                          value: CheckedList.contains(booking),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text("Page 2"),
            ],
          ),
        ));
  }
}
