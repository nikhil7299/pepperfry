//? USER INFO STATE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/core/dev_tools.dart';
import 'package:pepperfry/models/user_info_state.dart';

final isAdminProvider = Provider((ref) {
  final userInfoState = ref.watch(userInfoStateProvider);
  if (userInfoState == null) {
    return false;
  }
  return userInfoState.type == 'admin';
});

final userInfoStateProvider =
    StateNotifierProvider<UserInfoStateNotifier, UserInfoState?>((ref) {
  return UserInfoStateNotifier();
});

class UserInfoStateNotifier extends StateNotifier<UserInfoState?> {
  UserInfoStateNotifier() : super(null);

  void setUser(String user) {
    state = UserInfoState.fromJson(user);
    'user mobile ${state!.phone}'.log();
  }

  void setUserFromModel(UserInfoState userInfoState) {
    state = userInfoState;
  }
}
