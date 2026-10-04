import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_task_radixweb/screens/user_detail_screen.dart';
import 'package:mock_task_radixweb/widgets/user_tile.dart';

import '../controllers/user_controller.dart';
import 'add_user_screen.dart │.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            onPressed: controller.fetchUsers,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUserScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: controller.searchUsers,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                print('isLoading = ${controller.isLoading.value}');
                print('errorMessage = ${controller.errorMessage.value}');
                print('users = ${controller.users}');
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Something went wrong.'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: controller.fetchUsers,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.users.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                if (controller.filteredUsers.isEmpty) {
                  return Center(child: Text('No matching users found.'));
                }

                return ListView.builder(
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.filteredUsers[index];

                    return UserTile(
                      user: user,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(user: user),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
