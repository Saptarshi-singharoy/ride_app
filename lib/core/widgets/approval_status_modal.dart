import 'package:flutter/material.dart';
import 'package:ride_app/core/widgets/approval_level_status.dart';
import 'package:ride_app/presentation/booking/booking_list/screens/booking_details_screen.dart';
import 'package:ride_app/utils/themes/themes.dart';

class ApprovalStatusModal extends StatelessWidget {
  const ApprovalStatusModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        DetailHeader(data: "Approval Details"),
        ApprovalLevelStatus(status: "Approved", level: "1 (line manager)"),
        ApprovalLevelStatus(status: "Pending", level: '2 (travel desk)'),
      ],
    );
  }
}
