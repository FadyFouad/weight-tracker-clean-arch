import 'package:dartz/dartz.dart';
import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/value_objects/email_value_object.dart';
import 'package:weight_tracker_demo/core/value_objects/password_value_object.dart';
import 'package:weight_tracker_demo/features/auth/domain/failures.dart';
import 'package:weight_tracker_demo/features/auth/domain/use_cases/register_use_case.dart';

abstract class AuthRepo {
  UserEntity getLoggedUser();

  Future<UserEntity> getUserById(String id);

  Future<void> logout();

  Future<Either<AuthFailure, UserEntity>> login();

  Future<Either<AuthFailure, Unit>> register(
    RegisterParams registerParams,
  );
}
