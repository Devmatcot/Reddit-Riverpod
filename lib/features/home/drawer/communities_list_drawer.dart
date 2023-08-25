import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/common/loader.dart';
import 'package:flutter_reddit/features/community/controller/community_controller.dart';
import 'package:flutter_reddit/model/communities_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../../community/screen/create_community.dart';

class CommunitiesListDrawer extends ConsumerWidget {
  const CommunitiesListDrawer({super.key});
  navigateToCommunity(BuildContext context, Community community) {
    return Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a community'),
              leading: const Icon(Icons.add),
              onTap: () {
                Routemaster.of(context).push(CreateCommunityScreen.path);
              },
            ),
            Expanded(
                child: ref.watch(userCommunityProvider).when(
                    data: (communities) {
                      return ListView.builder(
                        itemCount: communities.length,
                        itemBuilder: (context, index) {
                          final community = communities[index];
                          return ListTile(
                            onTap: () {
                              navigateToCommunity(context, community);
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(community.avatar),
                            ),
                            title: Text('r/${community.name}'),
                          );
                        },
                      );
                    },
                    error: (_, stack) => Text(stack.toString()),
                    loading: () => Loader()))
          ],
        ),
      ),
    );
  }
}
