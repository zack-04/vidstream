import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';

final userDataServiceProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserDataService {
  UserDataService({
    required this.auth,
    required this.firestore,
  });
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  addUserDataToFirestore({
    required String displayName,
    required String userName,
    required String email,
    required String profilePic,
    required String description,
  }) async {
    UserModel userModel = UserModel(
      displayName: displayName,
      userName: userName,
      email: email,
      profilePic: profilePic,
      coverImageUrl: '',
      subscribedChannels: [],
      subscribers: [],
      userId: auth.currentUser!.uid,
      description: description,
      type: "user",
    );

    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .set(userModel.toMap());
  }

  Stream<UserModel> fetchCurrenUserData() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Future<List<UserModel>> fetchSubscribedChannels(
      List<String> subscribedUserIds) async {
    if (subscribedUserIds.isEmpty) {
      return [];
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where(FieldPath.documentId, whereIn: subscribedUserIds)
          .get();
      

      return snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    } catch (e) {
      print('Error : $e');
    }
    return [];
  }

  Stream<UserModel> fetchAnyUserData(userId) {
    try {
      return FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data()!));
    } catch (e) {
      print(e.toString());
      return const Stream.empty();
    }
  }
}
