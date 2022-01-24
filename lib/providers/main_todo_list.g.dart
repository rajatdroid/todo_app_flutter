// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_todo_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemListHome _$ItemListHomeFromJson(Map<String, dynamic> json) => ItemListHome(
      taskList: (json['taskList'] as List<dynamic>?)
              ?.map((e) => TaskNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ItemListHomeToJson(ItemListHome instance) =>
    <String, dynamic>{
      'taskList': instance.taskList,
    };
