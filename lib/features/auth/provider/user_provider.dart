import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/repository/user_data_service.dart';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserProvider = StreamProvider<UserModel?>((ref) {
   final authState = ref.watch(authStateChangesProvider).asData?.value;
  if (authState == null) {
    // Return an empty stream if there's no authenticated user
    return Stream.value(null);
  }
  return ref.watch(userDataServiceProvider).fetchCurrenUserData();
});

final anyDataUserProvider =
    StreamProvider.family<UserModel, String>((ref, userId) {
  return ref.watch(userDataServiceProvider).fetchAnyUserData(userId);
});

final subscribedChannelsProvider = FutureProvider<List<UserModel>>((ref) async {
  final currentUser = ref.watch(currentUserProvider);
  final subscribedChannels = currentUser.value!.subscribedChannels;

  return ref
      .watch(userDataServiceProvider)
      .fetchSubscribedChannels(subscribedChannels);
});
