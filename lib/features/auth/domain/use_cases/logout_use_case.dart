import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/core/value_objects/email_value_object.dart';
import 'package:weight_tracker_demo/core/value_objects/password_value_object.dart';
import 'package:weight_tracker_demo/features/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  @override
  Future<void> call(NoParams) {
    return authRepo.logout();
  }
}
