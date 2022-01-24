import 'package:flutter_app/models/task_item_with_level.dart';

import 'package:json_annotation/json_annotation.dart';

part 'todonode.g.dart';

@JsonSerializable()
class TaskNode {
  final TaskItemWithLevel parent;
  final List<TaskItemWithLevel> children;

  TaskNode({required this.parent, required this.children});

  factory TaskNode.fromJson(Map<String, dynamic> json) => _$TaskNodeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TaskNodeToJson(this);

}