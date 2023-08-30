import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/model/communities_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/utilis/snackbar.dart';
import '../../../provider/storage_repostory_provider.dart';
import '../repository/community_repository.dart';

final communityControlerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(
      storageRepository: ref.watch(storageRepositoryProvider),
      communityRepository: ref.read(communityRepoProvider),
      ref: ref);
});

final userCommunityProvider = StreamProvider((ref) {
  final community = ref.watch(communityControlerProvider.notifier);
  return community.getUserCommunity();
});

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  final community = ref.watch(communityControlerProvider.notifier);
  return community.getCommunityByName(name);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepostory;
  final StorageRepository _storageRepository;
  final Ref _ref;
  CommunityController(
      {required CommunityRepository communityRepository,
      required StorageRepository storageRepository,
      required Ref ref})
      : _communityRepostory = communityRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createCommunity(BuildContext context, String name) async {
    state = true;
    String uid = _ref.watch(userProvider)?.uid ?? "";
    Community community = Community(
        id: name,
        name: name,
        banner: Constants.bannerDefault,
        avatar: Constants.avatarDefault,
        members: [uid],
        mods: [uid]);
    final res = await _communityRepostory.createCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Community created succesfully');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunity() {
    String uid = _ref.read(userProvider)!.uid;
    return _communityRepostory.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepostory.getCommunityByName(name);
  }

  updateCommunity(BuildContext context, File? banner, File? profile,
      Community community) async {
    state = true;
    if (profile != null) {
      final res = await _storageRepository.storeFile(
          path: 'communities/profile', id: community.name, file: profile);
      res.fold((l) => showSnackBar(context, l.message),
          (r) => community = community.copyWith(avatar: r));
    }
    if (banner != null) {
      final res = await _storageRepository.storeFile(
          path: 'communities/banner', id: community.name, file: banner);
      res.fold((l) => showSnackBar(context, l.message),
          (r) => community = community.copyWith(banner: r));
    }

    final res = await _communityRepostory.editCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message),
        (r) => Routemaster.of(context).pop());
  }
}
