// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker_demo/core/app_routes.dart';
import 'package:weight_tracker_demo/core/local_data_source_initlaizer.dart';
import 'package:weight_tracker_demo/core/network/network_info.dart';
import 'package:weight_tracker_demo/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:weight_tracker_demo/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:weight_tracker_demo/features/auth/domain/use_cases/login_use_case.dart';
import 'package:weight_tracker_demo/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:weight_tracker_demo/features/weights_history/data/local/data_sources/posts_local_data_source.dart';
import 'package:weight_tracker_demo/features/weights_history/data/remote/data_sources/posts_remote_data_source.dart';
import 'package:weight_tracker_demo/features/weights_history/data/repositories/posts_repo.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/use_cases/load_posts_use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';


class Injection {
  static final getIt = GetIt.instance;

  static setup() async {
    openDatabase('path');
    final LocalDataSourceInitializer localDataSourceInitializer =
        LocalDataSourceInitializer();
    await localDataSourceInitializer.openDatabaseConnection();
    getIt.registerSingleton<Database>(localDataSourceInitializer.database);
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    final firebaseAuth = getIt.get<FirebaseAuth>();
    getIt.registerSingleton<AppRoutes>(AppRoutes(firebaseAuth));

    getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(UsersRemoteDataSource(getIt.get<FirebaseAuth>()),
          getIt.get<FirebaseAuth>()),
    );
    getIt.registerLazySingleton(
      () => PostsRepoImpl(
          PostsRemoteDataSource(firebaseAuth),
          PostsLocaleDataSource(localDataSourceInitializer.database),
          NetworkInfoImpl(DataConnectionChecker()),
          getIt.get<AuthRepoImpl>(),
         ),
    );
    getIt.registerFactory<PostsBloc>(() => PostsBloc(
        LoadPostsUseCase(getIt.get<PostsRepoImpl>()),
        ));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(LoginUseCase(
          getIt.get<AuthRepoImpl>(),
        )));
  }
}
