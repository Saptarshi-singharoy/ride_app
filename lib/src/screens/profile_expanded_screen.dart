import 'package:flutter/material.dart';

class ProfileExpandedScreen extends StatelessWidget {
  const ProfileExpandedScreen({super.key, required this.imgUrl, required this.name, required this.desig});

  final String imgUrl;
  final String name;
  final String desig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(tag: 'img-tag-$imgUrl',child:Image(image: NetworkImage(imgUrl),)),
          Text(name),
          Text(desig),
        ],
      ),
    );
  }
}