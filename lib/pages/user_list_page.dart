import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_exercise/model/user_model.dart';
import 'package:github_exercise/pages/user_list_page_provider.dart';
import 'package:go_router/go_router.dart';


class UserListPage extends ConsumerWidget{
  // const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final userListPageApi=ref.watch(userListPageProvider);
    final userList=ref.watch(userStateProvider).userList;
    return Scaffold(
        appBar: AppBar(
          title: Text('UserList page'),
        ),
        body: userList.when(
            data: (userList) => ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(user.avatarUrl),
                      title: Text(user.name),
                      subtitle: Text(user.reposUrl),
                      onTap: (){
                        userListPageApi.getUserDetail(user.name);
                        GoRouter.of(context).go('/${user.id}');
                      },
                    )
                  );
                }),
            error: (e, __) => Text(e.toString()),
            loading: () => const Center(child: CircularProgressIndicator())));
  }



}




