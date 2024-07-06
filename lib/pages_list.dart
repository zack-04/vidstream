import 'package:flutter/material.dart';
import 'package:vidstream/features/account/account_page.dart';
import 'package:vidstream/features/account/subscriptions_page.dart';
import 'package:vidstream/features/contents/Long_video/long_video_screen.dart';
import 'package:vidstream/features/contents/Short_video/pages/short_video_page.dart';

List pages = [
  const LongVideoScreen(),
  const ShortVideoPage(),
  const Center(
    child: Text("upload"),
  ),
  const SubscriptionsPage(),
  const AccountPage(),
];
