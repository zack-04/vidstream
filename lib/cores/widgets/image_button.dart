// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final bool haveColor;
  const ImageButton({
    super.key,
    required this.onPressed,
    required this.image,
    required this.haveColor,
  });

  @override
  Widget build(BuildContext context) {
    const Color softBlueGreyBackGround = Color(0xffF2F2F2);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          padding: const EdgeInsets.only(top: 7.6, bottom: 7.6),
          decoration: BoxDecoration(
            color: haveColor ? softBlueGreyBackGround : null,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Image.asset(
            "assets/icons/$image",
            height: 23,
          ),
        ),
      ),
    );
  }
}
