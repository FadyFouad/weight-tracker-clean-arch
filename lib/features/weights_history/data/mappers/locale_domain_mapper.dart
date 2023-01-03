import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/features/weights_history/data/local/models/post_local_data_model.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';

class LocalDomainMapper {
  static List<Post> toDomainList(
      List<PostLocalDataModel> localData, UserEntity uploader) {
    return localData
        .map((e) => Post(
            id: e.id,
              weight: e.weight,
              time: e.time,
            ))
        .toList();
  }

  static PostLocalDataModel toLocalDataModel(Post post) {
    return PostLocalDataModel(
      weight: post.weight,
      time: post.time,
      id: post.id,
    );
  }

  static List<PostLocalDataModel> toLocalDataModelList(List<Post> localData) {
    return localData.map((e) => toLocalDataModel(e)).toList();
  }
}
