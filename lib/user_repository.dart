import 'package:flutter_app/user_block.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/user.dart';


class UserRepository {
  Future<User> getUser() {
    return getUserAsync();
  }

  Future<User> getUserAsync() async {
    final response = await http.get("https://jsonplaceholder.typicode.com/todos/1");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }
}