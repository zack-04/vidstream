import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

final eachChannelVideosprovider = FutureProvider.family((ref, userId) async {
  final videosMap = await FirebaseFirestore.instance
      .collection('videos')
      .where('userId', isEqualTo: userId)
      .get();
  final videos = videosMap.docs;
  final List<LongVideoModel> videoModels =
      videos.map((video) => LongVideoModel.fromMap(video.data())).toList();
  return videoModels;
});
