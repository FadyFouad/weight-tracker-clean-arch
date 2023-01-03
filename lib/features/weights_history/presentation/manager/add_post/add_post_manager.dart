import 'package:weight_tracker_demo/core/injection.dart';
import 'package:weight_tracker_demo/features/weights_history/data/repositories/posts_repo.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/use_cases/add_post_use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/add_post/add_post_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addPostProvider =
    StateNotifierProvider.autoDispose<AddPostManager, AddPostState>((ref) {
  return AddPostManager(
      AddPostsUseCase(
        Injection.getIt.get<PostsRepoImpl>(),
      ));
});

class AddPostManager extends StateNotifier<AddPostState> {
  final AddPostsUseCase addPostsUseCase;

  AddPostManager(this.addPostsUseCase) : super(AddPostState.initial());

  void onChangedWeight(String value) {
    state = state.copyWith(weight: value);
  }

  Future<void> addPost() async {
    final result = await addPostsUseCase
        .call(AddPostParams(time: DateTime.now(), weight: state.weight));
    result.fold((l) => null, (r) => null);
  }
}
