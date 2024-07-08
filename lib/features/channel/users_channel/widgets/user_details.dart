import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 35,
          backgroundImage: CachedNetworkImageProvider(
            user.profilePic,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color.fromRGBO(96, 96, 96, 1.0),
              ),
            ),
            Row(
              children: [
                Text(
                  renderSubscriptionText(user.subscribers),
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color.fromRGBO(96, 96, 96, 1.0),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.circle,
                  size: 5,
                ),
                const SizedBox(width: 5),
                Consumer(
                  builder: (context, ref, child) {
                    return ref
                        .watch(eachChannelVideosProvider(user.userId))
                        .when(
                          data: (data) {
                            return Text(
                              "${data.length} videos",
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : const Color.fromRGBO(96, 96, 96, 1.0),
                              ),
                            );
                          },
                          error: (error, stackTrace) => const ErrorPage(),
                          loading: () => const Loader(),
                        );
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }
}