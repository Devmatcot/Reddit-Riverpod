import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_reddit/provider/failure.dart';
import 'package:flutter_reddit/provider/firebase_provider.dart';
import 'package:flutter_reddit/provider/typedef.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final storageRepositoryProvider = Provider((ref) {
  return StorageRepository(firebaseStorage: ref.read(storageProvider));
});

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile(
      {required String path, required String id, required File? file}) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask task = ref.putFile(file!);
      final snapshot = await task;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return right(downloadURL);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
