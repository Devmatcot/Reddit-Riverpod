import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_reddit/core/constants/firebase_constants.dart';
import 'package:flutter_reddit/provider/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/communities_model.dart';
import '../../../provider/firebase_provider.dart';
import '../../../provider/typedef.dart';

final communityRepoProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepository(firestore: ref.read(fireStoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _communties =>
      _firestore.collection(FirebaseConstants.communitiesCollection);

  FutureVoid createCommunity(Community community) async {
    try {
      final exitCommunities = await _communties.doc(community.name).get();
      if (exitCommunities.exists) {
        throw 'Communities with same name already exit';
      }
      return right(_communties.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  Stream<List<Community>> getUserCommunities(String uid) {
    return _communties
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<Community> community = [];
      for (var doc in event.docs) {
        community.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return community;
    });
  }

  Stream<Community> getCommunityByName(String name) {
    return _communties.doc(name.replaceAll('%20', ' ')).snapshots().map(
        (event) => Community.fromMap(event.data() as Map<String, dynamic>));
  }
}
