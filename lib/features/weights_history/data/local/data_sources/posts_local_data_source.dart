import 'package:weight_tracker_demo/core/constants/sqflite_constants.dart';
import 'package:weight_tracker_demo/core/sqflite.dart';
import 'package:weight_tracker_demo/features/weights_history/data/local/models/post_local_data_model.dart';
import 'package:sqflite/sqflite.dart';

class PostsLocaleDataSource extends SqfLiteLocalDataSource<PostLocalDataModel> {
  final Database database;

  PostsLocaleDataSource(this.database)
      : super(database, SqfLiteConstants.postsTable,
            (map) => PostLocalDataModel.fromMap(map));
}
