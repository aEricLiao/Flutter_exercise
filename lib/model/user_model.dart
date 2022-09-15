


import 'package:flutter_riverpod/flutter_riverpod.dart';

class User{
     int id=0;
     String avatarUrl='';
     String name='';
     String reposUrl='';
    User.fromJson(json){
        id=json['id'];
        avatarUrl=json['avatar_url'];
        name=json['login'];
        reposUrl=json['repos_url'];
    }

}

class UserDetail{
  int id=0;
  String avatarUrl='';
  String name='';
  String reposUrl='';
  String blog='';
  String company='';
  String location='';

  UserDetail.fromJson(json){
    id=json['id']??'';
    avatarUrl=json['avatar_url']??'';
    name=json['name']??'';
    reposUrl=json['repos_url']??'';
    blog=json['blog']??'';
    company=json['company']??'';
    location=json['location']??'';
  }
}

class UserState {
  final AsyncValue<UserDetail> currentUser;
  final AsyncValue<List<User>> userList;

  UserState({ this.currentUser=const AsyncValue.loading(), this.userList=const AsyncValue.loading()});

  UserState copyWith({List<User>? userList, UserDetail? currentUser}) {
    return UserState(
        userList: userList != null ? AsyncValue.data(userList) : this.userList,
        currentUser: currentUser != null
            ? AsyncValue.data(currentUser)
            : this.currentUser);
  }
}

class UserStateNotifier extends StateNotifier<UserState>{
  UserStateNotifier():super(UserState());

  void updateUserList(List<User> userList){
    state=state.copyWith(userList:userList );
  }
  void updateCurrentUser(UserDetail currentUser){
    state=state.copyWith(currentUser:currentUser );
  }
}

final userStateProvider = StateNotifierProvider<UserStateNotifier,UserState>((ref){
  return UserStateNotifier();
});