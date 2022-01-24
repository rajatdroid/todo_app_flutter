import 'package:flutter_app/models/task_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_item_with_level.g.dart';

@JsonSerializable()
class TaskItemWithLevel  {

  final TaskLevel taskLevel;
  final TaskItem taskItem;

  const TaskItemWithLevel({required this.taskLevel,required this.taskItem });

  factory TaskItemWithLevel.fromJson(Map<String, dynamic> json) => _$TaskItemWithLevelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TaskItemWithLevelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskItemWithLevel &&
              runtimeType == other.runtimeType &&
              taskLevel == other.taskLevel &&
              taskItem == other.taskItem ;

  @override
  int get hashCode => taskItem.hashCode + taskLevel.hashCode + 37;

}

enum TaskLevel{
@JsonValue('home')
HOME,
@JsonValue('one')
ONE,
@JsonValue('two')
TWO
}