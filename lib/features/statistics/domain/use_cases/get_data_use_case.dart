import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/features/auth/domain/repositories/auth_repo.dart';

class GetDataUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepo authRepo;

  GetDataUseCase(this.authRepo);

  @override
  UserEntity call(NoParams params) {
    return authRepo.getLoggedUser();
  }
}
