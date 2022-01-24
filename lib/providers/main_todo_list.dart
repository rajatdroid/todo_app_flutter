

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/task_item_with_level.dart';
import 'package:flutter_app/models/todonode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_todo_list.g.dart';

@JsonSerializable()
class ItemListHome extends ChangeNotifier{

  List<TaskNode> taskList = [];

  ItemListHome({required this.taskList});

  TaskItemWithLevel getTaskItem(TaskItemWithLevel key){
    return taskList.firstWhere((element) => identical(element.parent, key)).parent;
  }

  void setItemList(List<TaskNode> taskList){
    this.taskList = taskList;
    notifyListeners();
  }

  void addNewTaskHome(TaskItemWithLevel newKey){
    newKey.taskItem.priority = getTasksForHome().length;
    TaskNode taskNode = TaskNode(parent: newKey, children: []);
    taskList.add(taskNode);
    notifyListeners();
  }

  void addNewKeyLevelOneOrTwo(TaskItemWithLevel newKey, TaskItemWithLevel parentItem){
    newKey.taskItem.priority = getChildrenLength(parentItem);
    TaskNode taskNode = TaskNode(parent: newKey, children: []);
    addToParent(parentItem, newKey);
    taskList.add(taskNode);
    notifyListeners();
  }

  void markNewKeyAsAdded(TaskItemWithLevel addedKey){
    addedKey.taskItem.isNewItem = false;
    addedKey.taskItem.isToBeChanged = false;
    notifyListeners();
  }


  void addToParent(TaskItemWithLevel parentItem, TaskItemWithLevel childItem){
    taskList.firstWhere((element) => identical(element.parent, parentItem)).children.add(childItem);
  }

  void deleteKey(TaskItemWithLevel keyToDelete){
    taskList.remove(taskList.firstWhere((element) => identical(element.parent, keyToDelete)));
    notifyListeners();
  }

  void markAKeyItemAsComplete(TaskItemWithLevel keyToBeMarkedAsComplete){
    getTaskItem(keyToBeMarkedAsComplete).taskItem.markAsComplete();
    notifyListeners();
  }

  void markItemForUpdate(TaskItemWithLevel key){
    getTaskItem(key).taskItem.markForUpdation();
    notifyListeners();
  }

  void updateTitle(TaskItemWithLevel key, String newTitle){
    getTaskItem(key).taskItem.updateTitle(newTitle);
    notifyListeners();
  }

  void markItemAsUnComplete(TaskItemWithLevel key){
    getTaskItem(key).taskItem.markAsUnComplete();
    notifyListeners();
  }


  void changePriorityForIncreasingIndex(int oldIndex, int newIndex, TaskLevel taskLevel, TaskItemWithLevel? nodeParent){

    Map taskNodeMap = identical(taskLevel, TaskLevel.HOME) ? getSortedTasklistForHome().asMap() : getListForLevelOneOrTwoBasedOnParent(nodeParent!).asMap();

    for(int currentIndex = oldIndex + 1 ; currentIndex <= newIndex ; currentIndex ++){
      TaskNode currentNode = taskNodeMap[currentIndex];
      currentNode.parent.taskItem.priority++;
    }

    TaskNode mainNode = taskNodeMap[oldIndex];
    mainNode.parent.taskItem.priority = taskNodeMap.length - newIndex - 1;

    notifyListeners();
  }

  void changePriorityForDecreasingIndex(int oldIndex, int newIndex, TaskLevel taskLevel , TaskItemWithLevel? nodeParent){

    Map taskNodeMap = identical(taskLevel, TaskLevel.HOME) ? getSortedTasklistForHome().asMap() : getListForLevelOneOrTwoBasedOnParent(nodeParent!).asMap();

    for(int currentIndex = oldIndex-1; currentIndex >= newIndex ; currentIndex --){
      TaskNode currentNode = taskNodeMap[currentIndex];
      currentNode.parent.taskItem.priority--;

    }

    TaskNode mainNode = taskNodeMap[oldIndex];
    mainNode.parent.taskItem.priority = taskNodeMap.length - newIndex - 1;

    notifyListeners();
  }

  /// Level one and Level Two Task Helper Methods
  ///

  List<TaskNode> getListForLevelOneOrTwoBasedOnParent(TaskItemWithLevel nodeParent){
    List<TaskNode> itemList = [];

    List<TaskItemWithLevel> childrenOfParentNode = [];

    // Getting the children of
    for (TaskNode taskNodeTemp  in taskList){
      if (identical(taskNodeTemp.parent, nodeParent)){
        childrenOfParentNode = taskNodeTemp.children;
        break;
      }
    }


    for(TaskNode taskNode in taskList){
      for(TaskItemWithLevel child in childrenOfParentNode){
        if(taskNode.parent == child){
          itemList.add(taskNode);
        }
      }
    }

    itemList.sort((TaskNode taskNodeOne , TaskNode taskNodeTwo)  => taskNodeTwo.parent.taskItem.priority.compareTo(taskNodeOne.parent.taskItem.priority));
    itemList.sort((TaskNode taskOne, TaskNode taskTwo) { if(taskOne.parent.taskItem.isCompleted) return 1 ; return -1; } );

    return itemList;
  }


  /// Level One and level two function ends


  /// Home Level Tasks

  List<TaskNode> getTasksForHome() => taskList.where((element) => identical(element.parent.taskLevel, TaskLevel.HOME)).toList();

  List<TaskNode> getSortedTasklistForHome(){
    var itemList = getTasksForHome();
    itemList.sort((TaskNode taskItemOne , TaskNode taskItemTwo)  => taskItemTwo.parent.taskItem.priority.compareTo(taskItemOne.parent.taskItem.priority));
    itemList.sort((TaskNode taskOne, TaskNode taskTwo) { if(taskOne.parent.taskItem.isCompleted) return 1 ; return -1; } );
    return itemList;
  }


  /// Home Level Function Ends

  int getChildrenLength(TaskItemWithLevel taskItemWithLevel) =>
      taskList.firstWhere((element) => identical(taskItemWithLevel, element.parent)).children.length;


  factory ItemListHome.fromJson(Map<String, dynamic> json) => _$ItemListHomeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ItemListHomeToJson(this);

}