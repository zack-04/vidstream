import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/image_button.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Manage videos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: ImageButton(
            onPressed: () {},
            image: "time-watched.png",
            haveColor: true,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: ImageButton(
            onPressed: () {},
            image: "pen.png",
            haveColor: true,
          ),
        ),
      ],
    );
  }
}
