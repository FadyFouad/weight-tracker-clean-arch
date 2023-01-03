import 'package:weight_tracker_demo/core/injection.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/data/repositories/posts_repo.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/use_cases/load_posts_use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:riverpod/riverpod.dart';

final postsProvider = StateNotifierProvider<PostList, PostsState>((ref) {
  return PostList(
    LoadPostsUseCase(
      Injection.getIt.get<PostsRepoImpl>(),
    ),
  );
});

class PostList extends StateNotifier<PostsState> {
  final LoadPostsUseCase loadPostsUseCase;

  PostList(
    this.loadPostsUseCase,
  ) : super(PostsInitial()) {
    loadPosts();
  }

  loadPosts() async {
    state = PostsLoadInProgress();
    final result = await loadPostsUseCase.call(NoParams());
    result.fold((l) => state = PostsLoadFailure(),
        (r) => state = PostsLoadSuccess(r, 'test'));
  }

  List<Post> get posts => (super.state as PostsLoadSuccess).posts;

  PostsLoadSuccess get postsLoadSuccessState =>
      (super.state as PostsLoadSuccess);

}
