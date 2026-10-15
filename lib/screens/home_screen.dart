import 'package:flutter/material.dart';
import 'package:mock_task_radixweb/screens/counter_screen.dart';
import 'package:mock_task_radixweb/screens/task_screen.dart';
import 'package:mock_task_radixweb/screens/user_list_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Practice App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            buildElevatedButton(
              context,
              'User Management App',
              Icons.person,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen()),
                );
              },
            ),
            buildElevatedButton(
              context,
              'Counter App',
              Icons.add_circle_outline,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CounterScreen(),
                  ),
                );
              },
            ),
            buildElevatedButton(
              context,
              'Login Form with Validation',
              Icons.format_align_center,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(),
                  ),
                );
              },
            ),
            buildElevatedButton(
              context,
              'My local change test button',
              Icons.format_align_center,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(),
                  ),
                );
              },
            ),
            buildElevatedButton(
              context,
              'Task Manager',
              Icons.task,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TaskScreen(),
                  ),
                );
              },
            ),
            buildElevatedButton(
              context,
              'Additional Button Navigating to No Where',
              Icons.smart_button,
              () {},
            ),
            buildElevatedButton(
              context,
              'New Non-Navigating Button',
              Icons.touch_app,
              () {},
            ),
            buildElevatedButton(
              context,
              'Another Button (No Navigation)',
              Icons.radio_button_unchecked,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
