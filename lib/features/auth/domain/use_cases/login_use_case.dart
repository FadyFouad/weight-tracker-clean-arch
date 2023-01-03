import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/failures/failures.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/core/value_objects/email_value_object.dart';
import 'package:weight_tracker_demo/core/value_objects/password_value_object.dart';
import 'package:weight_tracker_demo/features/auth/domain/repositories/auth_repo.dart';

import '../failures.dart';

class LoginUseCase implements FailureUseCase<UserEntity, LoginParams> {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  @override
  Future<Either<AuthFailure, UserEntity>> call(LoginParams params) {
    return authRepo.login();
  }
}

class LoginParams {


  LoginParams();
  // from json
  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(

    );
  }
}
