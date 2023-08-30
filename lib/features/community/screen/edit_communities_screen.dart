import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/common/loader.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/core/extenstion/widget.dart';
import 'package:flutter_reddit/core/utilis/snackbar.dart';
import 'package:flutter_reddit/model/communities_model.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/community_controller.dart';

class EditCommunitiesScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunitiesScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditGroupScreenState();
}

class _EditGroupScreenState extends ConsumerState<EditCommunitiesScreen> {
  File? banner;
  File? profile;

  void selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        banner = File(res.files.first.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profile = File(res.files.first.path!);
      });
    }
  }

  void editCommunity(Community community) {
    ref
        .read(communityControlerProvider.notifier)
        .updateCommunity(context, banner, profile, community);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(communityControlerProvider);
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
        data: (community) => Scaffold(
              appBar: AppBar(
                title: const Text('Edit Community'),
                actions: [
                  TextButton(
                      onPressed: () => editCommunity(community),
                      child: const Text('Save'))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    isLoading
                        ? Column(
                            children: [
                              const LinearProgressIndicator(),
                              20.0.spacingH,
                            ],
                          )
                        : 5.0.spacingH,
                    SizedBox(
                      height: 170,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: selectBannerImage,
                            child: DottedBorder(
                              // borderPadding: const EdgeInsets.all(10),
                              dashPattern: const [10, 5],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              strokeWidth: 2,
                              color: Pallete.darkModeAppTheme.textTheme
                                  .bodyMedium!.color!,
                              child: Container(
                                // padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: banner != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          banner!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : community.banner.isEmpty ||
                                            community.banner ==
                                                Constants.bannerDefault
                                        ? const Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 40,
                                            ),
                                          )
                                        : Image.network(
                                            community.banner,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: selectProfileImage,
                              child: profile != null
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage: FileImage(profile!),
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(community.avatar),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => Text('$error'),
        loading: () => const Center(child: Loader()));
  }
}
