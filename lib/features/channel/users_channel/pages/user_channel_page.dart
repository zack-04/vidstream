// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';

class UserChannelPage extends StatefulWidget {
  final String userId;
  const UserChannelPage({
    super.key,
    required this.userId,
  });

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(anyDataUserProvider(widget.userId)).when(
                        data: (user) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 35,
                                    backgroundImage: CachedNetworkImageProvider(
                                      user.profilePic,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.displayName,
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '@${user.userName}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            user.subscriptions.isEmpty
                                                ? 'No subscriptions'
                                                : "${user.subscriptions.length} subscriptions",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.circle,
                                            size: 5,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${user.videos} videos',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              user.description.isNotEmpty
                                  ? Row(
                                      children: [
                                        Text(
                                          user.description,
                                          style: const TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        const Icon(Icons.arrow_right_outlined)
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  text: 'Subscribe',
                                  onPressed: () {},
                                  colour: Colors.black,
                                ),
                              ),
                              user.videos == 0
                                  ? const Text(
                                      'No videos',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 10,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${user.displayName} videos',
                                          style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
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
                      .watch(eachChannelVideosprovider(widget.userId))
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
    );
  }
}
