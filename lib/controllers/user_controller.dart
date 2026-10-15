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
      _applySearch();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchUsers(String query) {
    searchText.value = query;
    _applySearch();
  }

  void _applySearch() {
    final query = searchText.value.trim().toLowerCase();

    if (query.isEmpty) {
      filteredUsers.assignAll(users);
      return;
    }

    final results = users.where((user) {
      return user.name.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query);
    }).toList();

    filteredUsers.assignAll(results);
  }

  void addUser(User user) {
    users.add(user);
    _applySearch();
  }
}
