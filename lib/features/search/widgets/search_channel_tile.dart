// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/channel/users_channel/pages/user_channel_page.dart';

class SearchChannelTile extends StatelessWidget {
  final UserModel user;
  const SearchChannelTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserChannelPage(userId: user.userId),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic),
          ),
          const SizedBox(
            width: 50,
          ),
          Column(
            children: [
              Text(
                user.displayName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '@${user.userName}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              Text(
                user.subscriptions.isEmpty
                    ? 'No subscribers'
                    : "${user.subscriptions.length} subscribers",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 42,
                child: FlatButton(
                  text: 'Subscribe',
                  onPressed: () {},
                  colour: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
