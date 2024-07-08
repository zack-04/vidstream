// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vidstream/features/upload/comments/comment_model.dart';

final commentProvider = Provider(
  (ref) => CommentRepository(firestore: FirebaseFirestore.instance),
);

class CommentRepository {
  final FirebaseFirestore firestore;
  CommentRepository({
    required this.firestore,
  });

  Future<void> uploadCommentToFirestore({
    required String commentText,
    required String videoId,
    required String userName,
    required String profilePic,
    required DateTime datePublished,
  }) async {
    String commentId = const Uuid().v4();
    CommentModel comment = CommentModel(
      commentText: commentText,
      videoId: videoId,
      commentId: commentId,
      userName: userName,
      profilePic: profilePic,
      datePublished: datePublished,
    );
    await firestore.collection('comments').doc(commentId).set(comment.toMap());
  }
}
