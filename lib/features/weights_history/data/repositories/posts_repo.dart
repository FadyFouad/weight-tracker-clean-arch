import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:weight_tracker_demo/core/failures/failures.dart';
import 'package:weight_tracker_demo/core/network/network_info.dart';
import 'package:weight_tracker_demo/features/auth/domain/repositories/auth_repo.dart';
import 'package:weight_tracker_demo/features/weights_history/data/local/data_sources/posts_local_data_source.dart';
import 'package:weight_tracker_demo/features/weights_history/data/mappers/locale_domain_mapper.dart';
import 'package:weight_tracker_demo/features/weights_history/data/mappers/remote_domain_mapper.dart';
import 'package:weight_tracker_demo/features/weights_history/data/remote/data_sources/posts_remote_data_source.dart';
import 'package:weight_tracker_demo/features/weights_history/data/remote/models/post_remote_data_model.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/repositories/posts_repo.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/use_cases/add_post_use_case.dart';
import 'package:uuid/uuid.dart';

class PostsRepoImpl implements PostsRepo {
  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocaleDataSource _localeDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  PostsRepoImpl(this._remoteDataSource, this._localeDataSource,
      this.networkInfo, this.authRepo,);

  @override
  Future<Either<Failure, List<Post>>> getAll() async {
    try {
      final posts = <Post>[];
      final result = await _remoteDataSource.getAll();
      for (int i = 0; i < result.length; i++) {
        final remotePost = result[i];
        final uploader = await authRepo.getUserById(remotePost.userId);

        final post = (RemoteDomainMapper.toDomain(remotePost, uploader));
        final local = await _localeDataSource.getOne(remotePost.id);
        if (local == null) {
          posts.add(post);
        }
      }
      return right(posts);
    } catch (e) {
      rethrow;
      return left(Failure());
    }

  }

  Future<Either<Failure, Unit>> add(AddPostParams params) async {
    try {

      if (await networkInfo.isConnected) {
        await _remoteDataSource.add(PostRemoteDataModel(
            id: Uuid().v4(),
            weight: params.weight,
            time: params.time,
            userId: authRepo.getLoggedUser().id));
        return right(unit);
      } else {
        return left(NetworkFailure());
      }
    } catch (e) {
      if (kDebugMode) rethrow;
      return left(UnexpectedFailure());
    }
  }

  Future<Either<Failure, Unit>> delete(String id) async {
    if (await networkInfo.isConnected) {
      await _remoteDataSource.delete(id);
      return right(unit);
    } else {
      return right(unit);
    }
  }

  Future<Either<Failure, Unit>> edit(String id, Post post) async {
    if (await networkInfo.isConnected) {
      return right(unit);
    } else {
      final result = await _localeDataSource
          .update(LocalDomainMapper.toLocalDataModel(post));
      return right(unit);
    }
  }


  @override
  Future<Either<Failure, Unit>> bookmark(Post post) async {
    try {
      final result =
          await _localeDataSource.add(LocalDomainMapper.toLocalDataModel(post));
      return right(unit);
    } catch (e) {
      rethrow;
      return left(Failure());
      print(e);
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllBookmarkedPosts() async {
    try {
      final result = await _localeDataSource.getAll();
      final uploader = authRepo.getLoggedUser();

      return right(LocalDomainMapper.toDomainList(result, uploader));
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unBookmark(Post post) async {
    try {
      final result = await _localeDataSource.delete(post.id);
      return right(unit);
    } catch (e) {
      return left(Failure());
    }
  }
}
