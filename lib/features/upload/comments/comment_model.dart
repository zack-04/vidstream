// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  final String commentText;
  final String videoId;
  final String commentId;
  final String userName;
  final String profilePic;
  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commentId,
    required this.userName,
    required this.profilePic,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentText': commentText,
      'videoId': videoId,
      'commentId': commentId,
      'userName': userName,
      'profilePic': profilePic,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentText: map['commentText'] as String,
      videoId: map['videoId'] as String,
      commentId: map['commentId'] as String,
      userName: map['userName'] as String,
      profilePic: map['profilePic'] as String,
    );
  }

  
}
