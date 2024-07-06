// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/utils/constants.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';
import 'package:vidstream/features/channel/users_channel/subscribe_repository.dart';
import 'package:vidstream/features/channel/users_channel/widgets/user_channel_app_bar.dart';
import 'package:vidstream/features/channel/users_channel/widgets/user_details.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';

class UserChannelPage extends ConsumerStatefulWidget {
  final String userId;
  const UserChannelPage({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends ConsumerState<UserChannelPage> {
  bool isThumbnailPresent = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(anyDataUserProvider(widget.userId)).when(
                            data: (user) {
                              return Column(
                                children: [
                                  UserChannelAppBar(
                                      displayName: user.displayName),
                                  const SizedBox(height: 5),
                                  Stack(
                                    children: [
                                      Container(
                                          height: 120,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  user.coverImageUrl.isNotEmpty
                                                      ? user.coverImageUrl
                                                      : DEFAULT_BANNER,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  UserDetails(user: user),
                                  const SizedBox(height: 10),
                                  user.description.isNotEmpty
                                      ? Row(
                                          children: [
                                            Text(
                                              user.description,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            const Icon(
                                                Icons.arrow_right_outlined)
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    child:
                                        Consumer(builder: (context, watch, _) {
                                      final isSubscribed =
                                          user.subscribers.contains(
                                        FirebaseAuth.instance.currentUser!.uid,
                                      );

                                      return FlatButton(
                                        text: isSubscribed
                                            ? 'Subscribed'
                                            : 'Subscribe',
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
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      );
                                    }),
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      return ref
                                          .watch(eachChannelVideosProvider(
                                              widget.userId))
                                          .when(
                                            data: (data) {
                                              return data.length == 0
                                                  ? const Text(
                                                      'No videos',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10,
                                                        top: 10,
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          '${user.displayName} videos',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            },
                                            error: (error, stackTrace) =>
                                                const ErrorPage(),
                                            loading: () => const Loader(),
                                          );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                            error: (error, stackTrace) => const ErrorPage(),
                            loading: () => const Loader(),
                          );
                    },
                  ),
                  //2nd consummer
                  Consumer(
                    builder: (context, ref, child) {
                      return ref
                          .watch(eachChannelVideosProvider(widget.userId))
                          .when(
                            data: (videos) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: videos.length,
                                  itemBuilder: (context, index) {
                                    if (videos.isNotEmpty) {
                                      return Post(video: videos[index]);
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              );
                            },
                            error: (error, stackTrace) => const ErrorPage(),
                            loading: () => const Loader(),
                          );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
