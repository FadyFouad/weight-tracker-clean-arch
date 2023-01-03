import 'package:dartz/dartz.dart';
import 'package:weight_tracker_demo/core/failures/failures.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/repositories/posts_repo.dart';

class LoadPostsUseCase implements FailureUseCase<List<Post>, NoParams> {
  final PostsRepo postsRepo;

  LoadPostsUseCase(this.postsRepo);

  @override
  Future<Either<Failure, List<Post>>> call(params) {
    return postsRepo.getAll();
  }
}
