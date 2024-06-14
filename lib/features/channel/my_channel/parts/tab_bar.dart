import 'package:flutter/material.dart';

class PageTabBar extends StatelessWidget {
  const PageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      labelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.white,
      tabAlignment: TabAlignment.start,
      indicatorPadding: EdgeInsets.only(top: 15),
      tabs: [
        Tab(
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Videos',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Shorts',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Playlists',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Channel',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Community',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Tab(
          child: Text(
            'About',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
