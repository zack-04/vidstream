import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/upload/comments/comment_model.dart';

final commentsProvider = StreamProvider.family<List<CommentModel>, String>((ref, videoId) {
  return FirebaseFirestore.instance
      .collection('comments')
      .where('videoId', isEqualTo: videoId)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CommentModel.fromMap(doc.data()))
          .toList());
});

