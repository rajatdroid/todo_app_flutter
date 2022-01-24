// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item_with_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItemWithLevel _$TaskItemWithLevelFromJson(Map<String, dynamic> json) =>
    TaskItemWithLevel(
      taskLevel: $enumDecode(_$TaskLevelEnumMap, json['taskLevel']),
      taskItem: TaskItem.fromJson(json['taskItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskItemWithLevelToJson(TaskItemWithLevel instance) =>
    <String, dynamic>{
      'taskLevel': _$TaskLevelEnumMap[instance.taskLevel],
      'taskItem': instance.taskItem,
    };

const _$TaskLevelEnumMap = {
  TaskLevel.HOME: 'home',
  TaskLevel.ONE: 'one',
  TaskLevel.TWO: 'two',
};
