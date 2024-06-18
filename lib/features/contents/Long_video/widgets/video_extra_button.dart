// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class VideoExtraButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  const VideoExtraButton({
    super.key,
    required this.text,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 237, 236, 236),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
