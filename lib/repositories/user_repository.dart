import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_exercise/model/user_model.dart';
import 'package:http/http.dart' as http;


class UserRepository{
  final apiUrl='api.github.com';
  final http.Client client=http.Client();

  List<User>? userList;
  UserDetail? currentUser;

  Future<List<User>> fetchUserList()async{
    final Uri url=Uri.https(apiUrl,'/users');
    final response = await client.get(url,headers:
    {'Accept': 'application/vnd.github+json'});


    switch (response.statusCode) {
      case 200:
        return (jsonDecode(response.body) as List).map((e) => User.fromJson(e)).toList();
      case 401:
        throw Exception('invalid ApiKey');
      case 404:
        throw Exception('not found');
      default:
        throw Exception('unknown');
    }
  }


  Future<UserDetail> fetchUserDetail({required String userName})async{
    final Uri url=Uri.https(apiUrl,'/users/$userName');
    final response = await client.get(url,headers:
    {'Accept': 'application/vnd.github+json'});


    switch (response.statusCode) {
      case 200:
        return (UserDetail.fromJson(jsonDecode(response.body)));
      case 401:
        throw Exception('invalid ApiKey');
      case 404:
        throw Exception('not found');
      default:
        throw Exception('unknown');
    }
  }
}

final userRepositoryProvider=Provider<UserRepository>((ref){
  return UserRepository();
});






//
// class UserRepository{
//   final apiUrl='api.github.com';
//   final http.Client client=http.Client();
//
//   List<User>? userList;
//   UserDetail? currentUser;
//
//   Future<List<User>> fetchUserList()async{
//     final Uri url=Uri.https(apiUrl,'/users');
//     final response = await client.get(url,headers:
//     {'Accept': 'application/vnd.github+json'});
//
//
//     switch (response.statusCode) {
//       case 200:
//         return (jsonDecode(response.body) as List).map((e) => User.fromJson(e)).toList();
//       case 401:
//         throw Exception('invalid ApiKey');
//       case 404:
//         throw Exception('not found');
//       default:
//         throw Exception('unknown');
//     }
//   }
//
//
//   Future<UserDetail> fetchUserDetail({required String userName})async{
//     final Uri url=Uri.https(apiUrl,'/user/$userName');
//     final response = await client.get(url,headers:
//     {'Accept': 'application/vnd.github+json'});
//
//
//     switch (response.statusCode) {
//       case 200:
//         return (jsonDecode(response.body);
//       case 401:
//         throw Exception('invalid ApiKey');
//       case 404:
//         throw Exception('not found');
//       default:
//         throw Exception('unknown');
//     }
//   }
// }
//
// final userRepositoryProvider=Provider<UserRepository>((ref){
//   return UserRepository();
// });