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
      subscriptions: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: "user",
    );

    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .set(userModel.toMap());
  }

 Future<UserModel> fetchCurrenUserData() async {
    final currentUserMap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .get();
    UserModel userModel = UserModel.fromMap(currentUserMap.data()!);
    return userModel;
  }
}
