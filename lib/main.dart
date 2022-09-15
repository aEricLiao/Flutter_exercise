import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_exercise/pages/user_detail_page.dart';
import 'package:github_exercise/pages/user_list_page.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(ProviderScope(child:App() ,) );
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home:  UserListScreen(),
    // );
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Github User',
    );
  }

  final GoRouter _router = GoRouter(
    redirect:(state){
      if(state.location==''){
        return '/userList';
      }
    } ,
    routes: <GoRoute>[
      GoRoute(
        path: '/userList',
        builder: (BuildContext context, GoRouterState state) {
          return UserListPage();
        },
      ),
      GoRoute(
        path: '/:id',
        builder: (BuildContext context, GoRouterState state) {
          return UserDetailPage();
        },
      ),
    ],
  );
}