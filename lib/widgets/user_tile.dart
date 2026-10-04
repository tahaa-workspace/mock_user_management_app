import 'package:flutter/material.dart';

import '../models/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const UserTile({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: Text(user.name[0].toUpperCase())),
      title: Text(user.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(user.email, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
