import 'package:flutter/material.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../drawer/communities_list_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ))
        ],
      ),
      drawer: const CommunitiesListDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.karma.toString()),
            TextButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOutUser();
              },
              child: const Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }
}
