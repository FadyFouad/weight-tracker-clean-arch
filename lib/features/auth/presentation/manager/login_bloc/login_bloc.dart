import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/core/value_objects/email_value_object.dart';
import 'package:weight_tracker_demo/core/value_objects/password_value_object.dart';
import 'package:weight_tracker_demo/features/auth/domain/failures.dart';
import 'package:weight_tracker_demo/features/auth/domain/use_cases/login_use_case.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
       if (event is LoginSubmitted) {
        final params = LoginParams();

        final result = await loginUseCase.call(params);
        emit(state.copyWith(authFailureOrSuccessOption: some(result)));
      }
    });
  }
}
