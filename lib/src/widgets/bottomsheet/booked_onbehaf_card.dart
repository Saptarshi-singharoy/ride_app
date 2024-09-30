import 'package:flutter/material.dart';
import 'package:ride_app/src/models/on_behalf.model.dart';

class BookedOnbehafCard extends StatelessWidget {
  const BookedOnbehafCard({super.key, required this.data});

  final OnBehalfModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(data.nameOfGuest),
          Text(data.from),
          Text(data.to),
          Text(data.guestType),
          Text(data.purpose),
          Text(data.ex1),
          Text(data.ex2),
          Text(data.ex3),
          Text(data.ex4),
        ],
      ),
    );
  }
}
