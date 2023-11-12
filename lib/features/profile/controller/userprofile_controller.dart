import 'package:flutter_reddit/features/profile/repository/user_profile_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileController extends StateNotifier<bool> {
  UserProfileRepository _userRepo;
  Ref _ref;

  UserProfileController(
      {required UserProfileRepository userRepo, required Ref ref})
      : _userRepo = userRepo,
        _ref = ref,
        super(false);
}
