import 'package:flutter/material.dart';
import 'package:vidstream/features/contents/Long_video/long_video_screen.dart';
import 'package:vidstream/features/contents/Short_video/pages/short_video_page.dart';

List pages = const [
  LongVideoScreen(),
  
   ShortVideoPage(),
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