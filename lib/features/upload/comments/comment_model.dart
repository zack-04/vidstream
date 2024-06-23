import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentText;
  final String videoId;
  final String commentId;
  final String userName;
  final String profilePic;
  final DateTime datePublished;

  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commentId,
    required this.userName,
    required this.profilePic,
    required this.datePublished,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentText': commentText,
      'videoId': videoId,
      'commentId': commentId,
      'userName': userName,
      'profilePic': profilePic,
      'datePublished': datePublished,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentText: map['commentText'] as String? ?? '',
      videoId: map['videoId'] as String? ?? '',
      commentId: map['commentId'] as String? ?? '',
      userName: map['userName'] as String? ?? '',
      profilePic: map['profilePic'] as String? ?? '',
      datePublished: map['datePublished'] is Timestamp
          ? (map['datePublished'] as Timestamp).toDate()
          : (map['datePublished'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int)
              : DateTime.now()),
    );
  }
}
