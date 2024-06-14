import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/features/auth/model/user_model.dart';

class TopHeader extends StatelessWidget {
  final UserModel userModel;
  const TopHeader({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 35,
              backgroundImage: CachedNetworkImageProvider(userModel.profilePic),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.displayName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userModel.userName,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${userModel.subscriptions.length} subscriptions",
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
                      "${userModel.videos} videos",
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
      ],
    );
  }
}
