import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_exercise/model/user_model.dart';


class UserDetailPage extends ConsumerWidget {
  // const UserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final currentUser = ref.watch(userStateProvider).currentUser;
    return currentUser.when(
        data: (user) {
          return Container(
            width: 300,
            child: Row(
              children: [
                Expanded(
                  flex: 3, // 20%
                  child: Container(),
                ),
                Expanded(
                  flex:4,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(user.avatarUrl),
                        Title(
                            color: Colors.black,
                            child: Text(
                              user.name,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                        InfoRow(children: [
                          const Icon(Icons.person),
                          Text(user.company)
                        ]),
                        InfoRow(children: [
                          const Icon(
                            Icons.place,
                          ),
                          Text(user.location)
                        ]),
                        InfoRow(children: [
                          const Icon(
                            Icons.link,
                          ),
                          Text(user.blog)
                        ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3, // 20%
                  child: Container(),
                ),
              ],
            ),
          );
        },
        error: (e, __) => Text(e.toString()),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}


class InfoRow extends StatelessWidget {
  final List<Widget> children;
  const InfoRow({ required this.children}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        child: Row(
          children: children,
      )
    );
  }
}
