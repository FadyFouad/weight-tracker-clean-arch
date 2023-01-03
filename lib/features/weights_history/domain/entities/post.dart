import 'package:equatable/equatable.dart';
import 'package:weight_tracker_demo/core/domain/entities/user_entity.dart';

class Post extends Equatable {
  final String weight;
  DateTime time;
  final String id;

  Post({
    required this.weight,
    required this.time,
    required this.id,
  });

  // copy with
  Post copyWith({
    String? id,
    String? weight,
    DateTime? date,
    int? likesCount,
    List<String>? userLikeIds,
    UserEntity? loggedUser,
  }) {
    return Post(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      time: date ?? this.time,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        weight,
        time,
        id,
      ];
}
