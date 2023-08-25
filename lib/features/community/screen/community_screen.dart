import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/common/loader.dart';
import 'package:flutter_reddit/core/extenstion/log.dart';
import 'package:flutter_reddit/core/extenstion/widget.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  final String communityName;
  const CommunityScreen({super.key, required this.communityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(communityName)).when(
          data: (community) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 150,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            community.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(community.avatar),
                            ),
                          ),
                          10.0.spacingH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'r/${community.name}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              community.mods.contains(user!.uid)
                                  ? OutlinedButton(
                                      onPressed: () {
                                        Routemaster.of(context).push(
                                            '/mod-tools/${community.name}');
                                      },
                                      child: const Text('Mod Tools'))
                                  : OutlinedButton(
                                      onPressed: () {},
                                      child: Text(
                                          community.members.contains(user.uid)
                                              ? 'Joined'
                                              : 'Join'),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: Text('Displaying Group post')),
          error: (e, s) {
            return Text(e.toString());
          },
          loading: () => const Loader()),
    );
  }
}
