// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todonode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskNode _$TaskNodeFromJson(Map<String, dynamic> json) => TaskNode(
      parent:
          TaskItemWithLevel.fromJson(json['parent'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>)
          .map((e) => TaskItemWithLevel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskNodeToJson(TaskNode instance) => <String, dynamic>{
      'parent': instance.parent,
      'children': instance.children,
    };
