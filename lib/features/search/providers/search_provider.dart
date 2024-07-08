import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

final allChannelProvider = Provider((ref) async {
  final usersMap = await FirebaseFirestore.instance.collection('Users').get();
  List<UserModel> users =
      usersMap.docs.map((user) => UserModel.fromMap(user.data())).toList();
  return users;
});

final allVideosProvider = Provider((ref) async {
  final videosMap = await FirebaseFirestore.instance.collection('videos').get();
  List<LongVideoModel> videos =
      videosMap.docs.map((video) => LongVideoModel.fromMap(video.data())).toList();
  return videos;
});

