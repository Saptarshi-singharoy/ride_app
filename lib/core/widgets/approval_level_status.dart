import 'package:flutter/material.dart';
import 'package:ride_app/presentation/booking/booking_list/screens/booking_details_screen.dart';
import 'package:ride_app/utils/themes/themes.dart';

class ApprovalLevelStatus extends StatelessWidget {
  final String status;
  final String? level;
  const ApprovalLevelStatus(
      {super.key, required this.status, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4,
        color: provideColorScheme(context).tertiary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Info(title: "Approval Level", info: level),
              Info(title: "Status", info: status),
              if (status != "Pending")
                Info(title: "Approved By", info: "Shyamal"),
              if (status != "Pending")
                Info(title: "Approved on", info: "12/08/24"),
            ],
          ),
        ),
      ),
    );
  }
}
