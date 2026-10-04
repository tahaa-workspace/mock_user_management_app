import 'package:get/get.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  final UserService userService = UserService();
  final RxList<User> users = <User>[].obs;
  final RxList<User> filteredUsers = <User>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedUsers = await userService.fetchUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchUsers(String query) async {
    searchText.value = query;
    if (query.trim().isEmpty) {
      filteredUsers.assignAll(users);
      return;
    }
    final searchQuery = query.toLowerCase().trim();

    final results = users.where((user) {
      print('user = ${user}');
      return user.name.toLowerCase().contains(searchQuery) ||
          user.email.toLowerCase().contains(searchQuery);
    }).toList();
    print('results = $results');

    filteredUsers.assignAll(results);
  }

  void addUser(User user) {
    users.add(user);

    if (searchText.value.trim().isEmpty) {
      filteredUsers.add(user);
    } else {
      searchUsers(searchText.value);
    }
  }
}
