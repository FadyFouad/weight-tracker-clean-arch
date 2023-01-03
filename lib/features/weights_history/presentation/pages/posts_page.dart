import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_demo/core/app_colors.dart';
import 'package:weight_tracker_demo/core/injection.dart';
import 'package:weight_tracker_demo/core/widgets/custom_pop_up.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/dialogs/add_post_dialog.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/posts_manager.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/widgets/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (BuildContext context) =>
          Injection.getIt.get<PostsBloc>()..add(LoadPosts()),
      child: PostsList(),
    );
  }
}

class PostsList extends ConsumerWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // ref.read(provider)
    final state = ref.watch(postsProvider);
    final notifier = ref.read(postsProvider.notifier);

    return RefreshIndicator(
      onRefresh: () {
        notifier.loadPosts();
        return Future.value(true);
      },
      child: Builder(
        // bloc: context.read<PostsBloc>(),
        builder: (
          _,
        ) {
          if (state is PostsLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostsLoadSuccess) {
            final posts = state.posts;
            return Stack(
              children: [
                ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = posts[index];
                    return PostCard(
                      onTapDelete: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomPopUp.errorSnackBar(
                                'This Button Unimplemented Yet'));
                        throw UnimplementedError(
                            'This Button Unimplemented Yet');
                      },
                      onTapEdit: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomPopUp.errorSnackBar(
                                'This Button Unimplemented Yet'));
                        throw UnimplementedError(
                            'This Button  Unimplemented Yet');
                      },
                      post: post,
                      index: index,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 16.h,
                    );
                  },
                ),
                Positioned(
                  right: 25.w,
                  bottom: 80.h,
                  child: FloatingActionButton(
                      backgroundColor: AppColors.accent,
                      child: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context, builder: (_) => AddPostDialog());
                      }),
                )
              ],
            );
          }
          return Center(
            child: Text('Error'),
          );
        },
      ),
    );
  }
}
