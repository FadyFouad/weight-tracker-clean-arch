import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_demo/core/app_colors.dart';
import 'package:weight_tracker_demo/core/app_routes.dart';
import 'package:weight_tracker_demo/core/injection.dart';
import 'package:weight_tracker_demo/core/value_objects/email_value_object.dart';
import 'package:weight_tracker_demo/core/value_objects/password_value_object.dart';
import 'package:weight_tracker_demo/core/widgets/custom_pop_up.dart';
import 'package:weight_tracker_demo/features/auth/domain/failures.dart';
import 'package:weight_tracker_demo/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:weight_tracker_demo/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (BuildContext context) {
        return Injection.getIt.get<LoginBloc>();
      },
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(() {}, (a) {
            late final String message;
            a.fold((l) {
              if (l is InvalidEmailFailure) {
                message = 'البريد الإلكتروني غير صحيح';
              }
              if (l is WrongPasswordFailure) {
                message = 'كلمة المرور غير صحيحة';
              }
              if (l is UserNotFoundFailure) {
                message = 'البريد الإلكتروني غير مسجل';
              }
              if (l is UserDisabledFailure) {
                message = 'البريد الإلكتروني معطل';
              }
              if (l is TooManyRequestFailure) {
                message = 'تم تسجيل الدخول عدة مرات ';
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(CustomPopUp.errorSnackBar(message));
            }, (r) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false);
            });
          });
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 27.5.h, bottom: 24.h),
                  child: Text('Login'),
                ),
                CustomTitledTextField(
                  name: 'E-mail',
                  textField: TextFormField(
                    enabled: false,
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(EmailChanged(email: EmailAddress(value)));
                    },
                  ),
                ),
                SizedBox(
                  height: 18.4.h,
                ),
                PasswordTextField(
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(PasswordChanged(password: Password(value!)));
                    },
                    text: 'Password',
                    validator: (value) {
                     return value;
                    }),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(height: 38.h),

                TextButton(
                  onPressed: () {
                      context.read<LoginBloc>().add(LoginSubmitted());
                  },
                  child: const Text('Login Without E-mail',
                      style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      minimumSize: Size(double.infinity, 40.h)),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
