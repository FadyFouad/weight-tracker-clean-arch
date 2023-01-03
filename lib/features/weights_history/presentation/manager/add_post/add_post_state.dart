

class AddPostState {
  final DateTime? time;
  final String weight;

  AddPostState(this.time, this.weight);

// initial state
  factory AddPostState.initial() => AddPostState(null, '');

  // copy with
  AddPostState copyWith({
    DateTime? time,
    String? weight,
  }) {
    return AddPostState(time ?? this.time, weight ?? this.weight);
  }
}
