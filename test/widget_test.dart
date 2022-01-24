// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app/models/task_item.dart';
import 'package:flutter_app/models/task_item_with_level.dart';
import 'package:flutter_app/models/todonode.dart';
import 'package:flutter_app/providers/main_todo_list.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {

  ItemListHome itemListHome = ItemListHome(taskList: []);

  test("Test for adding new todo item in home", (){

    // Arrange
    TaskItemWithLevel addedHomeTask = TaskItemWithLevel(taskLevel: TaskLevel.HOME, taskItem: TaskItem(title: 'Home'));

    // Act
    itemListHome.addNewTaskHome(addedHomeTask);

    // Assert
    expect(itemListHome.taskList.length, 1);

  });

  test("Test for adding new todo child item in level 2", (){

    // Arrange
    TaskItemWithLevel addedParent = TaskItemWithLevel(taskLevel: TaskLevel.HOME, taskItem: TaskItem(title: 'parent'));
    TaskItemWithLevel addedChild = TaskItemWithLevel(taskLevel: TaskLevel.ONE, taskItem: TaskItem(title: 'child'));


    // Act
    itemListHome.addNewTaskHome(addedParent);
    itemListHome.addNewKeyLevelOneOrTwo(addedChild, addedParent);
    // Assert
    expect(itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'parent').children.length, 1);

  });

  test("Test for method to mark as complete", (){
    // Arrange

    // Act
    itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'parent').parent.taskItem.markAsComplete();

    // Assert
    expect(itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'parent').parent.taskItem.isCompleted, true);
  });

  test("Test for method to mark as InComplete", (){
    // Arrange

    // Act
    itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'parent').parent.taskItem.markAsUnComplete();

    // Assert
    expect(itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'parent').parent.taskItem.isCompleted, false);
  });

  test("Test for method to update the title of an item", (){
    // Arrange

    // Act
    itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'parent').parent.taskItem.title = 'new parent';
    itemListHome.markItemForUpdate(itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'new parent').parent);

    /// Printing all nodes
    for(TaskNode taskItem in itemListHome.taskList) { debugPrint(taskItem.parent.taskItem.title); }

    // Assert
    /// Checking the children length to double check that existing element was updated
    expect(itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'new parent').children.length, 1);
  });

  test("Test for method to remove an item", (){
    // Arrange

    // Act
    itemListHome.deleteKey(itemListHome.taskList.firstWhere((element) => element.parent.taskItem.title == 'child').parent);

    /// Printing all nodes
    for(TaskNode taskItem in itemListHome.taskList) { debugPrint(taskItem.parent.taskItem.title); }

    // Assert
    /// Checking the children length to double check that existing element was updated
    expect(itemListHome.taskList.length, 2);
  });
}
