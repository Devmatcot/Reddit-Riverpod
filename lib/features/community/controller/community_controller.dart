import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/features/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/model/communities_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../../../core/utilis/snackbar.dart';
import '../repository/community_repository.dart';

final communityControlerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(
      communityRepository: ref.read(communityRepoProvider), ref: ref);
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
  final Ref _ref;
  CommunityController(
      {required CommunityRepository communityRepository, required Ref ref})
      : _communityRepostory = communityRepository,
        _ref = ref,
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
}
