import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/injection.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:weight_tracker_demo/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:weight_tracker_demo/features/statistics/domain/use_cases/get_data_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileProvider =
    ChangeNotifierProvider.autoDispose<ProfileProvider>((ref) {
  return ProfileProvider(
    GetDataUseCase(Injection.getIt.get<AuthRepoImpl>()),
    LogoutUseCase(Injection.getIt.get<AuthRepoImpl>()),
  );
});

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(
    this.getProfileUseCase,
    this.logoutUseCase,
  ) {
    userEntity = getProfileUseCase.call(NoParams());
  }

  final GetDataUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  late final UserEntity userEntity;

  // logout
  Future<void> logout() async {
    await logoutUseCase.call(NoParams());
  }
}
