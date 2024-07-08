// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscribeChannelProvider = StateNotifierProvider<SubscribeNotifier, bool>(
  (ref) => SubscribeNotifier(FirebaseFirestore.instance),
);

class SubscribeNotifier extends StateNotifier<bool> {
  FirebaseFirestore firebaseFirestore;
  SubscribeNotifier(
    this.firebaseFirestore,
  ) : super(false);

  
  Future<void> handleSubscription({
    required String userId,
    required String currentUserId,
    required bool isSubscribed,
  }) async {

    try {
      if (isSubscribed) {
        await firebaseFirestore.collection("Users").doc(currentUserId).update({
          "subscribedChannels": FieldValue.arrayRemove([userId]),
        });
        await firebaseFirestore.collection("Users").doc(userId).update({
          "subscribers": FieldValue.arrayRemove([currentUserId]),
        });
      } else {
        await firebaseFirestore.collection("Users").doc(currentUserId).update({
          "subscribedChannels": FieldValue.arrayUnion([userId]),
        });
        await firebaseFirestore.collection("Users").doc(userId).update({
          "subscribers": FieldValue.arrayUnion([currentUserId]),
        });
      }
    } catch (error) {
      // Handle errors appropriately
      log("Error toggling subscription: $error");
    }
  }

  
}
