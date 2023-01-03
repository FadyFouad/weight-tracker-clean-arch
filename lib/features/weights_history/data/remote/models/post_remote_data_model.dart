import 'package:weight_tracker_demo/core/firestore_crud_operations.dart';

class PostRemoteDataModel extends FirestoreDocumentModel {
  final String weight;
  DateTime time;
  final String userId;

  PostRemoteDataModel(
      {required this.weight,
      required this.time,
      required this.userId,
      required String id})
      : super(id);

  PostRemoteDataModel.fromFirestoreDocument(super.doc)
      : weight = doc['weight'],
        time = DateTime.parse(doc['time'].toDate().toString()),
        userId = doc['uploader'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'time': time,
      'uploader': userId,
    };
  }

  PostRemoteDataModel copyWith({
    String? id,
    String? weight,
    DateTime? date,
    List<String>? userLikeIds,
    String? uploader,
  }) {
    return PostRemoteDataModel(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      time: date ?? this.time,
      userId: uploader ?? this.userId,
    );
  }
}
