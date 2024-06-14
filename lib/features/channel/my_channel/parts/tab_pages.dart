import 'package:flutter/material.dart';

class TabPages extends StatelessWidget {
  const TabPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          Center(
            child: Text('Home'),
          ),
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
