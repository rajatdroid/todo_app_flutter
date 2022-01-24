// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      title: json['title'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      priority: json['priority'] as int? ?? 0,
      isNewItem: json['isNewItem'] as bool? ?? false,
      isToBeChanged: json['isToBeChanged'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'priority': instance.priority,
      'isNewItem': instance.isNewItem,
      'isToBeChanged': instance.isToBeChanged,
    };
