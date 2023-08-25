import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/common/loader.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/core/extenstion/widget.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/community_controller.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  static const String path = '/create-communities';
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  TextEditingController _communityController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _communityController.dispose();
  }

  void createCommunities() {
    ref
        .read(communityControlerProvider.notifier)
        .createCommunity(context, _communityController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a community'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Community name',
              style: TextStyle(fontSize: 16),
            ),
            5.0.spacingH,
            TextField(
              controller: _communityController,
              maxLength: 21,
              decoration: const InputDecoration(
                  hintText: 'r/Community_name',
                  filled: true,
                  fillColor: Pallete.greyColor,
                  border: InputBorder.none),
            ),
            20.0.spacingH,
            Consumer(
              builder: (context, ref, child) {
                final provide = ref.watch(communityControlerProvider);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Pallete.blueColor),
                  onPressed: createCommunities,
                  child: provide
                      ? const Loader()
                      : const Text(
                          'Create Community',
                          style: TextStyle(fontSize: 20),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
