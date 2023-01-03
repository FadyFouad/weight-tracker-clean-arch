import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';
import 'package:weight_tracker_demo/features/weights_history/data/remote/models/post_remote_data_model.dart';
import 'package:weight_tracker_demo/features/weights_history/domain/entities/post.dart';

class RemoteDomainMapper {
  static Post toDomain(PostRemoteDataModel remoteData, UserEntity uploader) {
    return Post(
        id: remoteData.id,
      weight: remoteData.weight,
      time: remoteData.time,
    );
  }

  static PostRemoteDataModel toPostRemoteDataModel(Post post) {
    return PostRemoteDataModel(
      id: post.id,
      userId: '',
      weight: post.weight,
      time: post.time,
    );
  }
}
