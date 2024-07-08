import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';
import 'package:vidstream/features/upload/short_video/model/short_video_model.dart';

final eachChannelVideosProvider = StreamProvider.family<List<LongVideoModel>, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('videos')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => LongVideoModel.fromMap(doc.data())).toList();
      });
});

final eachChannelShortsVideosProvider = StreamProvider.family<List<ShortVideoModel>, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('shorts')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => ShortVideoModel.fromMap(doc.data())).toList();
      });
});