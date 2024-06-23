import 'package:flutter/material.dart';
import 'package:vidstream/features/channel/my_channel/pages/home_channel_page.dart';

class TabPages extends StatelessWidget {
  const TabPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          HomeChannelPage(),
          Center(
            child: Text('Videos'),
          ),
          Center(
            child: Text('Shorts'),
          ),
          Center(
            child: Text('Playlists'),
          ),
          Center(
            child: Text('Channel'),
          ),
          Center(
            child: Text('Communtiy'),
          ),
          Center(
            child: Text('About'),
          )
        ],
      ),
    );
  }
}
