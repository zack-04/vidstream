// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final bool showBgColor;
  const ImageButton({
    Key? key,
    required this.onPressed,
    required this.image,
    this.showBgColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: showBgColor == true
                ? Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade200
                : Colors.transparent,
          ),
          child: Image.asset(
            "assets/icons/$image",
            color: Theme.of(context).iconTheme.color,
            height: 23,
          ),
        ),
      ),
    );
  }
}
