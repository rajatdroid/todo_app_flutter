import 'package:json_annotation/json_annotation.dart';

part 'task_item.g.dart';

@JsonSerializable()
class TaskItem {

  String title;
  bool isCompleted;
  int priority ;
  bool isNewItem;
  bool isToBeChanged;

  TaskItem({this.title = '' , this.isCompleted = false, this.priority = 0 , this.isNewItem = false, this.isToBeChanged = false});

  void markAsComplete(){
    priority = 0 - priority;
    isCompleted = true;
  }

  void updateTitle(String title){
    title = title;
  }

  void markAsUnComplete(){
    priority = 0 - priority;
    isCompleted = false;
  }

  void setPriority(int priority){
    priority = priority;
  }

  void markForUpdation() {
    isToBeChanged = true;
  }

  factory TaskItem.fromJson(Map<String, dynamic> json) => _$TaskItemFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskItem &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              priority == other.priority &&
              isCompleted == other.isCompleted ;

  @override
  int get hashCode => title.hashCode + priority.hashCode + isCompleted.hashCode + 37;




}