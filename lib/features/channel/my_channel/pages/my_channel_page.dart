import 'package:flutter/material.dart';
import 'package:vidstream/features/channel/my_channel/parts/buttons.dart';
import 'package:vidstream/features/channel/my_channel/parts/tab_bar.dart';
import 'package:vidstream/features/channel/my_channel/parts/tab_pages.dart';
import 'package:vidstream/features/channel/my_channel/parts/top_header.dart';

class MyChannelPage extends StatelessWidget {
  const MyChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 7,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopHeader(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'More about this channel',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Icon(Icons.arrow_right_outlined)
                  ],
                ),
                SizedBox(height: 20),
                Buttons(),
                SizedBox(height: 20),
                PageTabBar(),
                TabPages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
