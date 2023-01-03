import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/core/app_colors.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/add_post/add_post_manager.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/manager/posts_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPostDialog extends ConsumerWidget {
  const AddPostDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(addPostProvider);
    final notifier = ref.read(addPostProvider.notifier);
    final loadNotifier = ref.read(postsProvider.notifier);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('What is Your Current Weight?',
              style: TextStyle(color: Color(0xffBECCD4))),
              TextFormField(
            keyboardType: TextInputType.number,
            onChanged: notifier.onChangedWeight,
            decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Weight in (KG)',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.accent,
                )),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.accent,
                  ),
                )),
              ),
              SizedBox(height: 37.h),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButtonTheme(
                  data: TextButtonThemeData(
                      style: TextButton.styleFrom(fixedSize: Size(77.w, 36.h))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',
                          style: TextStyle(color: AppColors.accent))),
                      TextButton(
                          onPressed: () async {
                            await notifier.addPost();
                            Navigator.pop(context);
                            loadNotifier.loadPosts();
                          },
                          child: const Text('Add',
                          style: TextStyle(color: Colors.white)),
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.accent)),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
