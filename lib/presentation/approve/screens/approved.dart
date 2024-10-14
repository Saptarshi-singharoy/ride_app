import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/widgets/booked_item_card.dart';
import 'package:ride_app/presentation/approve/provider/approved/approved_provider.dart';

class Approved extends ConsumerWidget {
  const Approved({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approvedList = ref.watch(approvedNotifierProvider);
    print(approvedList);
    return ListView.builder(
        itemCount: approvedList.length,
        itemBuilder: (context, index) {
          final booking = approvedList[index];

          return Padding(
            padding: const EdgeInsets.all(8),
            child: BookedItemCard(
              booking: booking,
              // delete: _showDeleteConformationDialog,
              // accept: _showAcceptConformationDialog
            ),
          );
        });
  }
}
