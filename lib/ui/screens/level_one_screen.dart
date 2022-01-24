import 'package:flutter/material.dart';
import 'package:flutter_app/models/task_item.dart';
import 'package:flutter_app/models/task_item_with_level.dart';
import 'package:flutter_app/models/todonode.dart';
import 'package:flutter_app/providers/main_todo_list.dart';
import 'package:flutter_app/ui/constants/label_constants.dart';
import 'package:flutter_app/ui/constants/ui_conatnts.dart';
import 'package:flutter_app/ui/custoimwidgets/swipable_list_tile.dart';
import 'package:flutter_app/ui/screens/level_two_screen.dart';
import 'package:provider/provider.dart';

class LevelOneScreen  extends StatelessWidget {

  final TaskItemWithLevel parentItem;

  const LevelOneScreen({Key? key, required this.parentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text( ' ${parentItem.taskItem.title}' ,
          style: kTextTheme.headline1,),
      ),

      body: SafeArea(child: LevelOneScaffoldBody(parentItem: parentItem,)),


    );
  }
}


class LevelOneScaffoldBody extends StatelessWidget {

  final TaskItemWithLevel parentItem;

  const LevelOneScaffoldBody({Key? key, required this.parentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListHome>(
      builder: (context, itemListHomeObj, widget) {

        return RefreshIndicator(
          onRefresh: () async{
            itemListHomeObj.addNewKeyLevelOneOrTwo(TaskItemWithLevel(taskLevel: TaskLevel.ONE,taskItem: TaskItem(isNewItem: true)), parentItem);
          },
          child: ReorderableListView.builder(
            itemCount: itemListHomeObj.getChildrenLength(parentItem)  ,
            itemBuilder: (context, index) {

              List<TaskNode> levelOneList = itemListHomeObj.getListForLevelOneOrTwoBasedOnParent(parentItem);
              TaskItemWithLevel taskItemWithLevel = levelOneList.asMap()[index]!.parent;

              return getHomeListTileWithGestures(
                taskItemWithLevel: taskItemWithLevel,
                childrenLength:  '${levelOneList.asMap()[index]!.children.length}',
                onRightSwiped: (context){ itemListHomeObj.markAKeyItemAsComplete(taskItemWithLevel); },
                onRightSwipedReverse: (context){ itemListHomeObj.markItemAsUnComplete(taskItemWithLevel); },
                onLeftSwiped: (context){ itemListHomeObj.deleteKey(taskItemWithLevel); },
                onItemClicked: (){itemListHomeObj.markItemForUpdate(taskItemWithLevel); },
                onCountClicked: (){ Navigator.push(context, MaterialPageRoute(builder: (context) =>  LevelTwoScreen(parentItem: taskItemWithLevel,)));},
                onItemAddedCallBack: (String string) {
                  taskItemWithLevel.taskItem.title = string;
                  itemListHomeObj.markNewKeyAsAdded(taskItemWithLevel);
                },
              );
            }, onReorder: (int oldIndex, int newIndex) {
            if(newIndex > oldIndex){
              itemListHomeObj.changePriorityForIncreasingIndex(oldIndex, newIndex-1, TaskLevel.ONE, parentItem);
            } else if(oldIndex > newIndex){
              itemListHomeObj.changePriorityForDecreasingIndex(oldIndex, newIndex, TaskLevel.ONE, parentItem);
            }
          },
          ),
        );
      },
    );
  }
}