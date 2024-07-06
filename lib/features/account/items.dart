import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/image_item.dart';
import 'package:vidstream/features/account/settings_screen.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 35,
            child: ImageItem(
              imageName: "your-channel.png",
              itemClicked: () {},
              itemText: "Your Channel",
            ),
          ),
          const SizedBox(height: 6.5),
          SizedBox(
            height: 34,
            child: ImageItem(
              imageName: "your-channel.png",
              itemClicked: () {},
              itemText: "Turn on Incognito",
            ),
          ),
          const SizedBox(height: 6.5),
          SizedBox(
            height: 34,
            child: ImageItem(
              imageName: "add-account.png",
              itemClicked: () {},
              itemText: "Add Account",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.blueGrey,
            ),
          ),
          SizedBox(
            height: 35,
            child: ImageItem(
              imageName: "purchases.png",
              itemClicked: () {},
              itemText: "Purchases and Membership",
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            height: 31,
            child: ImageItem(
              imageName: "time-watched.png",
              itemClicked: () {},
              itemText: "Time watched",
            ),
          ),
          const SizedBox(height: 9),
          SizedBox(
            height: 31,
            child: ImageItem(
              imageName: "your-data.png",
              itemClicked: () {},
              itemText: "Your data in Youtube",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.blueGrey,
            ),
          ),
          SizedBox(
            height: 33,
            child: ImageItem(
              imageName: "settings.png",
              itemClicked: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              itemText: "Settings",
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 35,
            child: ImageItem(
              imageName: "help.png",
              itemClicked: () {},
              itemText: "Help & feedback",
            ),
          ),
        ],
      ),
    );
  }
}
