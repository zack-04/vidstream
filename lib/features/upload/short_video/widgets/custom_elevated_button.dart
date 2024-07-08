// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
   final void Function() onPressed;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
