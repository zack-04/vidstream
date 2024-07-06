// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int index) onPressed;
  const BottomNavigation({
    super.key,
    required this.onPressed,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.video,
          ),
          label: 'Shorts',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
              ),
            ),
          ),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.solidBell,
          ),
          label: 'Subscriptions',
        ),
        BottomNavigationBarItem(
          icon: Consumer(
            builder: (context, ref, child) {
              return ref.watch(currentUserProvider).when(
                    data: (currentUser) => CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(
                        currentUser.profilePic,
                      ),
                    ),
                    error: (error, stackTrace) => const ErrorPage(),
                    loading: () => const Loader(),
                  );
            },
          ),
          label: 'You',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
        widget.onPressed(value);
      },
    );
  }
}
