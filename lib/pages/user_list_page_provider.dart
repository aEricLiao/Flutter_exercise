
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_exercise/model/user_model.dart';
import 'package:github_exercise/repositories/user_repository.dart';

class UserListPageApi {
  final UserRepository _userRepository;
  final UserStateNotifier _userStateNotifier;

  UserListPageApi(this._userRepository,this._userStateNotifier) {
    getUserList();
  }

  Future<void> getUserList()async{
    final userList= await  _userRepository.fetchUserList();
    _userStateNotifier.updateUserList(userList);
  }

  Future<void> getUserDetail(String userName)async{
    final userDetail= await  _userRepository.fetchUserDetail(userName: userName);
    _userStateNotifier.updateCurrentUser(userDetail);
  }
}


final userListPageProvider = Provider<
    UserListPageApi
>((ref){
  final userRepository=ref.watch(userRepositoryProvider);
  final userStateNotifier=ref.read(userStateProvider.notifier);

  return UserListPageApi(userRepository,userStateNotifier);
});




//
// class UserListPageNotifier extends StateNotifier<AsyncValue<List<User>>>{
//   final UserRepository _userRepository;
//   final UserStateNotifier _userStateApi;
//
//   UserListPageNotifier(this._userRepository,this._userStateApi)
//       :super(const AsyncValue.loading()){
//     getUserList();
//   }
//
//   Future<void> getUserList()async{
//     final userList= await  _userRepository.fetchUserList();
//     state=AsyncValue.data(userList);
//     _userStateApi.updateUserList(userList)
//   }
// }
//
//
// final userListPageProvider = StateNotifierProvider<
//     UserListPageNotifier,
//     AsyncValue<List<User>>
// >((ref){
//   final userRepository=ref.watch(userRepositoryProvider);
//   final userStateApi=ref.read(userStateProvider.notifier);
//
//   return UserListPageNotifier(userRepository,userStateApi);
// });