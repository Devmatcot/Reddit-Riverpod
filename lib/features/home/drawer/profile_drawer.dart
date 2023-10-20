import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/extenstion/widget.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user.profilePic),
            ),
            10.0.spacingH,
            Text(
              'u/${user.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            10.0.spacingH,
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person_4),
              onTap: () {
                //Routemaster.of(context).push(CreateCommunityScreen.path);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(
                Icons.logout,
                color: Pallete.redColor,
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).signOutUser();
                // Routemaster.of(context).push(CreateCommunityScreen.path);
              },
            ),
            Switch.adaptive(value: true, onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}
