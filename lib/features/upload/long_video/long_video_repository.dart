// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

final longVideoProvider = Provider(
  (ref) => LongVideoRepository(firestore: FirebaseFirestore.instance),
);


class LongVideoRepository {
  FirebaseFirestore firestore;
  LongVideoRepository({
    required this.firestore,
  });

  uploadVideoToFirestore({
    required String videoUrl,
    required String thumbnail,
    required String title,
    required String description,
    required String videoId,
    required DateTime datePublished,
    required String userId,
  }) async {
    LongVideoModel video = LongVideoModel(
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        title: title,
        description: description,
        datePublished: datePublished,
        views: 0,
        videoId: videoId,
        userId: userId,
        likes: [],
        type: "video");
    await firestore.collection('videos').doc(videoId).set(video.toMap());
  }

  Future<void> likeVideo({
    required List? likes,
    required videoId,
    required currentUserId,
  }) async {
    if (!likes!.contains(currentUserId)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(videoId)
          .update({
        'likes': FieldValue.arrayUnion([currentUserId])
      });
    }
    if (likes.contains(currentUserId)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(videoId)
          .update({
        'likes': FieldValue.arrayRemove([currentUserId])
      });
    }
  }

  Future<void> incrementVideoCount(String userId) async {
    await FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'videos': FieldValue.increment(1),
    });
  }
}
