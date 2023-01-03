import 'package:dartz/dartz.dart';
import 'package:weight_tracker_demo/core/failures/failures.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/repositories/posts_repo.dart';

class AddPostsUseCase implements FailureUseCase<Unit, AddPostParams> {
  final PostsRepo postsRepo;

  AddPostsUseCase(this.postsRepo, );

  @override
  Future<Either<Failure, Unit>> call(AddPostParams params) {

    return postsRepo.add(params);
  }
}

class AddPostParams {
  final DateTime time;
  final String weight;

  AddPostParams({required this.time, required this.weight});
}
