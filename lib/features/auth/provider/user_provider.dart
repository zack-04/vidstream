import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/repository/user_data_service.dart';

final currentUserProvider = StreamProvider<UserModel>((ref) {
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
