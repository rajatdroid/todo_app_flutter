import 'package:flutter_app/models/task_item.dart';
import '../models/task_item.dart';

Map<TaskItem, List<TaskItem>> getItemMaps(){
  return {
    TaskItem(title: 'First Item ', priority: 1) : gettaskItemList(),
    TaskItem(title: 'Second Item ', priority: 2) : gettaskItemList(),
    TaskItem(title: 'Third Item ', priority: 3) : gettaskItemList(),
    TaskItem(title: 'Fourth Item ', priority: 4) : gettaskItemList(),
  };
}


List<TaskItem> gettaskItemList() => [for(int i =1; i < 11; i ++) i].map((e) => TaskItem(title : 'This is taskItem $e', isCompleted: false , priority: e )).toList();