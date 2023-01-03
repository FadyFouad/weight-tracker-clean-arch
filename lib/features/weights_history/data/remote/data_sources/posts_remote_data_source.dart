import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker_demo/core/firestore_crud_operations.dart';
import 'package:weight_tracker_demo/features/weights_history/data/remote/models/post_remote_data_model.dart';

class PostsRemoteDataSource
    extends FirestoreCrudOperations<PostRemoteDataModel> {
  final FirebaseAuth firebaseAuth;

  PostsRemoteDataSource(this.firebaseAuth)
      : super('posts',
            (snapshot) => PostRemoteDataModel.fromFirestoreDocument(snapshot));


}
