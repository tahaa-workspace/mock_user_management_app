import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch users. HTTP status: ${response.statusCode}',
      );
    }

    final decodedData = jsonDecode(response.body);

    if (decodedData is! List) {
      throw const FormatException('Expected a list of users from the API.');
    }

    return decodedData
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
