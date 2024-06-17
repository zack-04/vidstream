import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/features/account/items.dart';
import 'package:vidstream/features/auth/model/user_model.dart';

class AccountPage extends StatelessWidget {
  final UserModel user;
  const AccountPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.profilePic),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.displayName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.userName,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Items(),
            ],
          ),
        ),
      ),
    );
  }
}
