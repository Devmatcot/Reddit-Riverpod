import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/common/loader.dart';
import 'package:flutter_reddit/features/community/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../model/communities_model.dart';

class SearchCommunityDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchCommunityDelegate({required this.ref});

  navigateToCommunity(BuildContext context, Community community) {
    return Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    return ref.watch(searchCommunityProvider(query)).when(
          data: (communities) => ListView.builder(
            itemCount: communities.length,
            itemBuilder: (context, index) {
              final community = communities[index];
              return ListTile(
                onTap: () => navigateToCommunity(context, community),
                title: Text('r/${community.name}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(community.avatar),
                ),
              );
            },
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(
            child: Loader(),
          ),
        );
  }
}
