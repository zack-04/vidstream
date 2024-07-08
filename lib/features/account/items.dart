import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vidstream/cores/widgets/account_item.dart';
import 'package:vidstream/features/auth/repository/auth_service.dart';
import 'package:vidstream/features/channel/my_channel/pages/my_channel_page.dart';
import 'package:vidstream/features/theme/theme_provider.dart';
import 'package:vidstream/next_screen.dart';

class Items extends ConsumerWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          AccountItem(
            itemText: "Your Channel",
            itemClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyChannelPage(),
                ),
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.user,
              size: 20,
            ),
          ),
          AccountItem(
            itemText: "Turn on Incognito",
            itemClicked: () {},
            icon: FaIcon(
              FontAwesomeIcons.user,
              size: 20,
            ),
          ),
          AccountItem(
            itemText: "Add Account",
            itemClicked: () {},
            icon: FaIcon(
              FontAwesomeIcons.userPlus,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade700
                  : Colors.blueGrey,
              thickness: 0.5,
            ),
          ),
          AccountItem(
            itemText: "Purchases and Membership",
            itemClicked: () {},
            icon: FaIcon(
              FontAwesomeIcons.dollarSign,
              size: 20,
            ),
          ),
          AccountItem(
            itemText: "Time watched",
            itemClicked: () {},
            icon: FaIcon(
              FontAwesomeIcons.chartSimple,
              size: 20,
            ),
          ),
          AccountItem(
            itemText: "Your data in Vidstream",
            itemClicked: () {},
            icon: FaIcon(
              FontAwesomeIcons.circleInfo,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade700
                  : Colors.blueGrey,
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: ListTile(
              title: const Text(
                'Dark theme',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              leading: FaIcon(FontAwesomeIcons.moon),
              trailing: Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: ref.watch(themeProvider) == ThemeMode.dark,
                  onChanged: (bool value) {
                    ref.read(themeProvider.notifier).toggleTheme(value);
                  },
                ),
              ),
            ),
          ),
          AccountItem(
            itemText: "Logout",
            itemClicked: () async {
              await ref.read(authServiceProvider).signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NextScreen(),
                ),
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
