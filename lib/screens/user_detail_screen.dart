import 'package:flutter/material.dart';

import '../models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Text(
                  user.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 16),

            Text('ID: ${user.id}'),
            const SizedBox(height: 8),

            Text('Email: ${user.email}'),
            const SizedBox(height: 8),

            Text('Phone: ${user.phone}'),
          ],
        ),
      ),
    );
  }
}