import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/search/pages/search_page.dart';

class UserChannelAppBar extends StatelessWidget {
  const UserChannelAppBar({super.key, required this.displayName});
  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 6),
        Text(
          displayName,
          style: const TextStyle(fontSize: 22),
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
    );
  }
}
