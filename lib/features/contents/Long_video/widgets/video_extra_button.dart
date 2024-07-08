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
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromRGBO(255, 255, 255, 0.1)
            : const Color.fromARGB(19, 63, 62, 62),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 18,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
