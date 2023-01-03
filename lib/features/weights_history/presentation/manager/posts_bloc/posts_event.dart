part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

// load
class LoadPosts extends PostsEvent {
  @override
  List<Object> get props => [];
}
