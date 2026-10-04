import 'package:dio/dio.dart';

import '../models/user.dart';

class UserService {
  final Dio dio = Dio();

  Future<List<User>> fetchUsers() async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      final List<dynamic> data = response.data;
      print('data = $data');
      print('data = ${data
          .map((json) => User.fromJson(json))
          .toList()}');
      return data
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch users: ${e.message}');
    }
  }
}