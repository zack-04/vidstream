import 'package:flutter/material.dart';
import 'package:vidstream/features/contents/Long_video/long_video_screen.dart';

List pages = const [
  LongVideoScreen(),
  Center(
    child: Text("Shorts"),
  ),
  
  // ShortVideoPage(),
  Center(
    child: Text("upload"),
  ),
  Center(
    child: Text("Subs"),
  ),
  Center(
    child: Text("Logout"),
  ),
  // SearchScreen(),
  // LogoutPage(),
];