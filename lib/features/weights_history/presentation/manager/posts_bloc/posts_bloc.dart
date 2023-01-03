import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker_demo/core/use_case/use_case.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/use_cases/load_posts_use_case.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final LoadPostsUseCase loadPostsUseCase;

  PostsBloc(
    this.loadPostsUseCase,
  ) : super(PostsInitial()) {
    initHandler();
  }

  initHandler() {
    on<PostsEvent>((event, emit) async {
      if (event is LoadPosts) {
        emit(PostsLoadInProgress());
        final result = await loadPostsUseCase.call(NoParams());
        result.fold((l) => emit(PostsLoadFailure()),
            (r) => emit(PostsLoadSuccess(r, 'test')));
      }
    });
  }

}
