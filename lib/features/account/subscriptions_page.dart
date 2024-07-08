import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/users_channel/pages/user_channel_page.dart';
import 'package:vidstream/features/search/pages/search_page.dart';

class SubscriptionsPage extends ConsumerStatefulWidget {
  const SubscriptionsPage({
    super.key,
  });

  @override
  ConsumerState<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends ConsumerState<SubscriptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 20),
              child: Row(
                children: [
                  const Text(
                    'All subscriptions',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 4),
                  const Spacer(),
                  SizedBox(
                    height: 45,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 43,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ref.watch(subscribedChannelsProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Text(
                        'No subscriptions found',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final channel = data[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserChannelPage(
                                      userId: data[index].userId),
                                ),
                              );
                            },
                            title: Text(
                              channel.displayName,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(channel.profilePic),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => ErrorPage(),
                  loading: () => Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Loader(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
