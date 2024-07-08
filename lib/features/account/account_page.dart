import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/account/items.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/my_channel/pages/my_channel_page.dart';
import 'package:vidstream/features/search/pages/search_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 50,
            child: ImageButton(
              image: "cast.png",
              onPressed: () {},
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            height: 45,
            child: ImageButton(
              image: "notification.png",
              onPressed: () {},
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            height: 48,
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
          SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyChannelPage(),
                              ),
                            );
                          },
                          child: Consumer(
                            builder: (context, ref, child) {
                              return ref.watch(currentUserProvider).when(
                                    data: (user) {
                                      return Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 40,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    user!.profilePic),
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
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '@${user.userName}',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  const Icon(
                                                    Icons.circle,
                                                    size: 5,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "View channel",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : const Color
                                                              .fromRGBO(
                                                              96, 96, 96, 1.0),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  FaIcon(
                                                    FontAwesomeIcons
                                                        .chevronRight,
                                                    size: 13,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : const Color.fromRGBO(
                                                            96, 96, 96, 1.0),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                    error: (error, stackTrace) =>
                                        const ErrorPage(),
                                    loading: () => const Loader(),
                                  );
                            },
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
            },
          ),
        ),
      ),
    );
  }
}
