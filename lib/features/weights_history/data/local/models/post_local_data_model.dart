import 'package:weight_tracker_demo/core/constants/sqflite_constants.dart';
import 'package:weight_tracker_demo/core/sqflite.dart';

class PostLocalDataModel extends SqfLiteLocalDataModel {
  final String weight;
  DateTime time;

  PostLocalDataModel(
      {required this.weight, required this.time, required String id})
      : super(id);

  PostLocalDataModel.fromMap(Map map)
      : weight = map[SqfLiteConstants.weightColumn],
        time = map[SqfLiteConstants.timeColumn],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      SqfLiteConstants.weightColumn: weight,
      SqfLiteConstants.timeColumn: time,
      ...super.toMap()
    };
  }
}
