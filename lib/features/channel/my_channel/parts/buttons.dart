import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/channel/my_channel/pages/my_channel_setting.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Manage videos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ImageButton(
          onPressed: () {},
          image: "time-watched.png",
          showBgColor: true,
        ),
        const SizedBox(
          width: 5,
        ),
        ImageButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyChannelSettings(),
              ),
            );
          },
          image: "pen.png",
          showBgColor: true,
        ),
      ],
    );
  }
}
