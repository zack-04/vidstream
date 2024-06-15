import 'package:flutter/material.dart';

class UserTopHeader extends StatelessWidget {
  const UserTopHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sony SAB",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "@SonySAB",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "92.8M subscribers",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.circle,
                      size: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "86K videos",
                      style: TextStyle(
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
