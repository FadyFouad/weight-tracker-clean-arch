part of 'login_bloc.dart';

@immutable
class LoginState {
  final Option<Either<AuthFailure, UserEntity>> authFailureOrSuccessOption;

  const LoginState(
      {
      required this.authFailureOrSuccessOption,});

  factory LoginState.initial() => LoginState(
        authFailureOrSuccessOption: none(),
      );

  //copy with
  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    Option<Either<AuthFailure, UserEntity>>? authFailureOrSuccessOption,
  }) {
    return LoginState(
      authFailureOrSuccessOption:
          authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
