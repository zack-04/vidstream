// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSettingsProvider = Provider(
  (ref) => EditSettingsField(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class EditSettingsField {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  EditSettingsField({
    required this.firestore,
    required this.auth,
  });

  editDisplayName(displayName) async {
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .update({"displayName": displayName});
  }

  editUserName(userName) async {
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .update({"userName": userName});
  }

  editDescription(description) async {
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .update({"description": description});
  }
}
