import 'package:flutter/material.dart';
import 'package:flutter_app/models/task_item.dart';
import 'package:flutter_app/models/task_item_with_level.dart';
import 'package:flutter_app/models/todonode.dart';
import 'package:flutter_app/providers/main_todo_list.dart';
import 'package:flutter_app/ui/constants/ui_conatnts.dart';
import 'package:flutter_app/ui/custoimwidgets/swipable_list_tile.dart';
import 'package:provider/provider.dart';

class LevelTwoScreen extends StatelessWidget {

  final TaskItemWithLevel parentItem;

  const LevelTwoScreen({Key? key, required this.parentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text( ' ${parentItem.taskItem.title} ',
          style: kTextTheme.headline1,),
      ),

      body: SafeArea(child: LevelTwoScaffoldBody(parentItem: parentItem,)),


    );
  }
}


class LevelTwoScaffoldBody extends StatelessWidget {

  final TaskItemWithLevel parentItem;

  const LevelTwoScaffoldBody({Key? key, required this.parentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListHome>(
      builder: (context, itemListHomeObj, widget) {

        return RefreshIndicator(
          onRefresh: () async{
            itemListHomeObj.addNewKeyLevelOneOrTwo(TaskItemWithLevel(taskLevel: TaskLevel.TWO,taskItem: TaskItem(isNewItem: true)), parentItem);
          },
          child: ReorderableListView.builder(
            itemCount: itemListHomeObj.getChildrenLength(parentItem),
            itemBuilder: (context, index) {

              TaskNode taskNode = itemListHomeObj.getListForLevelOneOrTwoBasedOnParent(parentItem).asMap()[index]!;
              TaskItemWithLevel taskItemWithLevel = taskNode.parent;

              return getHomeListTileWithGestures(
                taskItemWithLevel: taskItemWithLevel,
                childrenLength:  '${taskNode.children.length}',
                onRightSwiped: (context){ itemListHomeObj.markAKeyItemAsComplete(taskItemWithLevel); },
                onRightSwipedReverse: (context){ itemListHomeObj.markItemAsUnComplete(taskItemWithLevel); },
                onLeftSwiped: (context){ itemListHomeObj.deleteKey(taskItemWithLevel); },
                onItemClicked: (){itemListHomeObj.markItemForUpdate(taskItemWithLevel); },
                onCountClicked: (){ },
                onItemAddedCallBack: (String string) {
                  taskItemWithLevel.taskItem.title = string;
                  itemListHomeObj.markNewKeyAsAdded(taskItemWithLevel);
                },
              );
            }, onReorder: (int oldIndex, int newIndex) {
            if(newIndex > oldIndex){
              itemListHomeObj.changePriorityForIncreasingIndex(oldIndex, newIndex-1, TaskLevel.TWO, parentItem);
            } else if(oldIndex > newIndex){
              itemListHomeObj.changePriorityForDecreasingIndex(oldIndex, newIndex, TaskLevel.TWO, parentItem);
            }
          },
          ),
        );
      },
    );
  }
}