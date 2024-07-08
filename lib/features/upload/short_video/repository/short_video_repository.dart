// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/upload/short_video/model/short_video_model.dart';

final shortVideoProvider = Provider(
  (ref) => ShortVideoRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ShortVideoRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ShortVideoRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> addShortVideoToFireStore({
    required String caption,
    required String shortVideo,
    required DateTime datePublished,
  }) async {
    ShortVideoModel shortVideoModel = ShortVideoModel(
      caption: caption,
      userId: auth.currentUser!.uid,
      shortVideo: shortVideo,
      datePublished: datePublished,
    );
    await firestore.collection('shorts').add(shortVideoModel.toMap());
  }
}
