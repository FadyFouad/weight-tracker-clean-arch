import 'package:dartz/dartz.dart';
import 'package:weight_tracker_demo/core/failures/failures.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/use_cases/add_post_use_case.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getAll();

  Future<Either<Failure, Unit>> add(AddPostParams addPostParams);


  Future<Either<Failure, Unit>> bookmark(Post post);

  Future<Either<Failure, Unit>> unBookmark(Post post);

  Future<Either<Failure, List<Post>>> getAllBookmarkedPosts();

  Future<Either<Failure, Unit>> delete(String id);

  Future<Either<Failure, Unit>> edit(String id, Post post);
}
