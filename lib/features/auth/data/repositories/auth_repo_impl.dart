import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker_demo/core/constants/constants.dart';
import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/failures/failures.dart';
import 'package:weight_tracker_demo/features/auth/data/exceptions.dart';
import 'package:weight_tracker_demo/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:weight_tracker_demo/features/auth/domain/failures.dart';
import 'package:weight_tracker_demo/features/auth/domain/repositories/auth_repo.dart';
import 'package:weight_tracker_demo/features/auth/domain/use_cases/register_use_case.dart';

class AuthRepoImpl implements AuthRepo {
  final UsersRemoteDataSource usersRemoteDataSource;
  final FirebaseAuth firebaseAuth;

  AuthRepoImpl(this.usersRemoteDataSource, this.firebaseAuth);

  UserEntity getLoggedUser() {
    User user = usersRemoteDataSource.getLoggedUser();
    return UserEntity(
      id: user.uid,
      name: user.displayName ?? 'Anonymous',
      profilePicture: user.photoURL ?? Constants.defaultAvatar,
      email: user.email ?? 'Anonymous',
    );
  }

  Future<Either<AuthFailure, UserEntity>> login() async {
    try {
      final result = await usersRemoteDataSource.login();
      return Right(UserEntity(id: '', name: '', email: '', profilePicture: ''));
    } on AuthException catch (e) {
      if (e is InvalidEmailException) {
        return Left(InvalidEmailFailure());
      } else if (e is WrongPasswordException) {
        return Left(WrongPasswordFailure());
      } else if (e is UserNotFoundException) {
        return Left(UserNotFoundFailure());
      } else if (e is UserDisabledException) {
        return Left(UserDisabledFailure());
      } else if (e is TooManyRequestException) {
        return Left(TooManyRequestFailure());
      } else {
        return Left(UnexpectedFailure());
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<UserEntity> getUserById(String id) async {
    final result = await usersRemoteDataSource.getOne(id);
    return UserEntity(
      id: result?.id ?? "Anonymous",
      name: result?.name ?? 'Anonymous',
      profilePicture: result?.profilePicture ?? '',
      email: result?.email ?? '',
    );
  }

  @override
  Future<Either<AuthFailure, Unit>> register(
      RegisterParams registerParams) async {
    try {
      final result = await usersRemoteDataSource.register(
          registerParams.fullName,
          registerParams.emailAddress.getOrCrash(),
          registerParams.password.getOrCrash());

      return right(unit);
    } on AuthException catch (e) {
      if (e is EmailAlreadyInUseException) {
        return Left((EmailAlreadyInUseFailure()));
      } else if (e is InvalidEmailException) {
        return Left(InvalidEmailFailure());
      } else if (e is WeakPasswordException) {
        return Left(WeakPasswordFailure());
      } else {
        return Left(UnexpectedFailure());
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut();
  }
}
