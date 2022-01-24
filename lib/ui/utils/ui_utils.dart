import 'package:flutter/material.dart';
import 'package:flutter_app/models/task_item.dart';
import 'package:flutter_app/models/task_item_with_level.dart';

Color getRedShadeBasedOnPriority(int value) => Color.lerp(Colors.yellow.shade50, Colors.red, value*0.1)!;

Color getBlueShadeBasedOnPriority(int value) => Color.lerp(Colors.green.shade50, Colors.blueAccent, value*0.1)!;

Color getShadesBasedOnPriority(TaskItem taskItem, TaskLevel taskLevel){

  int value = taskItem.priority;

  if(taskItem.isCompleted){
    return Colors.white;
  }

  switch (taskLevel){
    case TaskLevel.HOME :  return  getRedShadeBasedOnPriority(value);
    case TaskLevel.ONE : return getBlueShadeBasedOnPriority(value);
    case TaskLevel.TWO : return getRedShadeBasedOnPriority(value);
  }
}

