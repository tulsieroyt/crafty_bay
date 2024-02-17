import 'package:flutter/material.dart';

class ProfileDetailsOptions extends StatelessWidget {
  const ProfileDetailsOptions(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        Text(
          description,
          maxLines: 5,
        ),
      ],
    );
  }
}
