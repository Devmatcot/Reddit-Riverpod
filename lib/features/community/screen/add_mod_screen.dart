import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/common/loader.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/features/community/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddModScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModScreen({required this.name, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModScreenState();
}

class _AddModScreenState extends ConsumerState<AddModScreen> {
  Set<String> uid = {};

  addUid(String id) {
    setState(() {
      uid.add(id);
    });
  }

  removeUid(String id) {
    setState(() {
      uid.remove(id);
    });
  }

  saveMod() {
    ref
        .read(communityControlerProvider.notifier)
        .addMod(context, widget.name, uid.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMod,
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
            data: (community) {
              return ListView.builder(
                itemCount: community.members.length,
                itemBuilder: (context, index) {
                  final member = community.members[index];
                  return ref.watch(getUserDataProvider(member)).when(
                        data: (value) {
                          if (community.mods.contains(member)) {
                            uid.add(member);
                          }
                          return CheckboxListTile(
                            value: uid.contains(value.uid),
                            onChanged: (val) {
                              if (val!) {
                                addUid(member);
                              } else {
                                removeUid(member);
                              }
                            },
                            title: Text(value.name),
                          );
                        },
                        error: (e, s) => Text(e.toString()),
                        loading: () => const Center(
                          child: Loader(),
                        ),
                      );
                },
              );
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(
              child: Loader(),
            ),
          ),
    );
  }
}
