// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/users_channel/pages/user_channel_page.dart';
import 'package:vidstream/features/channel/users_channel/subscribe_repository.dart';

class SearchChannelTile extends ConsumerStatefulWidget {
  final UserModel userModel;
  const SearchChannelTile({
    super.key,
    required this.userModel,
  });

  @override
  ConsumerState<SearchChannelTile> createState() => _SearchChannelTileState();
}

class _SearchChannelTileState extends ConsumerState<SearchChannelTile> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(anyDataUserProvider(widget.userModel.userId)).when(
          data: (user) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade700,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserChannelPage(userId: user.userId),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                CachedNetworkImageProvider(user.profilePic),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.displayName,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '@${user.userName}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                renderSubscriptionText(user.subscribers),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 36,
                                child: Consumer(
                                  builder: (context, watch, _) {
                                    final isSubscribed =
                                        user.subscribers.contains(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    );

                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                      onPressed: () async {
                                        await ref
                                            .read(subscribeChannelProvider
                                                .notifier)
                                            .handleSubscription(
                                              userId: user.userId,
                                              currentUserId: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              isSubscribed: isSubscribed,
                                            );
                                      },
                                      child: Text(
                                        isSubscribed
                                            ? 'Subscribed'
                                            : 'Subscribe',
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            );
          },
          error: (error, stackTrace) => ErrorPage(),
          loading: () => Loader(),
        );
  }
}
