import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/core/extenstions/string_extension.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/posts_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostCard extends ConsumerWidget {
  const PostCard(
      {Key? key,
      required this.onTapDelete,
      required this.onTapEdit,
      required this.post,
      required this.index})
      : super(key: key);
  final Post post;
  final int index;
  final VoidCallback onTapDelete;
  final VoidCallback onTapEdit;

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(postsProvider.notifier);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xff2A557934),
              blurRadius: 12,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Row(
          children: [
            IconButton(onPressed: onTapEdit, icon: Icon(Icons.edit)),
            IconButton(onPressed: onTapDelete, icon: Icon(Icons.delete)),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.5.h),
              child: Text('KG ${post.weight}',
                  style: Theme.of(context).textTheme.displaySmall),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.5.h),
          child: Text('${post.time}'.toDateTime()),
        ),
      ]),
    );
  }
}
