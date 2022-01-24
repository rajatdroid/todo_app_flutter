import 'package:flutter/material.dart';
import 'package:flutter_app/models/task_item_with_level.dart';
import 'package:flutter_app/ui/constants/ui_conatnts.dart';
import 'package:flutter_app/ui/utils/ui_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


/// This widget creates the list tile with pull to refresh i.e showing textfield for new item
/// and also provides on click functionality on list tile item
Widget getHomeListTileWithGestures({ required TaskItemWithLevel taskItemWithLevel,
  required String childrenLength,
  required Function() onItemClicked ,
  required Function() onCountClicked ,
  required Function(BuildContext) onRightSwiped,
  required Function(BuildContext) onRightSwipedReverse,
  required Function(BuildContext) onLeftSwiped,
  required Function(String) onItemAddedCallBack }){

  return taskItemWithLevel.taskItem.isNewItem  ? getNewIItemTextField(taskItemWithLevel, onItemAddedCallBack) :
  getSwipableListTile(onRightSwiped: onRightSwiped, onRightSwipedReverse: onRightSwipedReverse,
      onLeftSwiped: onLeftSwiped ,taskItemWithLevel: taskItemWithLevel,childrenLength: childrenLength, onItemClicked: onItemClicked, onCountClicked: onCountClicked, onItemAddedCallBack: onItemAddedCallBack);

}


/// This method return the swipable tile (left & right swipe action),
/// for deleting and 'marking as completed' an item
Widget getSwipableListTile({required Function(BuildContext) onRightSwiped,
  required Function(BuildContext) onRightSwipedReverse,
  required Function(BuildContext) onLeftSwiped,
  required TaskItemWithLevel taskItemWithLevel,
  required String childrenLength,
  required Function() onItemClicked,
  required Function() onCountClicked ,
  required Function(String string) onItemAddedCallBack}){

  return Slidable(

      key: Key('${taskItemWithLevel.taskItem.priority}'),

      startActionPane: ActionPane(
        motion: const ScrollMotion(),

        children:   [
          SlidableAction(
            onPressed: taskItemWithLevel.taskItem.isCompleted ? onRightSwipedReverse : onRightSwiped ,
            backgroundColor: Colors.green,
            icon: taskItemWithLevel.taskItem.isCompleted ? Icons.restore : Icons.done,
            foregroundColor: Colors.white,
          ),
        ],
      ),

      endActionPane: ActionPane(
        motion: const ScrollMotion(),

        children: [
          SlidableAction(
            onPressed: onLeftSwiped ,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            foregroundColor: Colors.white,
          ),
        ],
      ),

      child: ListTile(
        tileColor: getShadesBasedOnPriority(taskItemWithLevel.taskItem, taskItemWithLevel.taskLevel),
        title:getTextOrTextFieldBasedOnAction(taskItemWithLevel, onItemClicked, onItemAddedCallBack),
        trailing: InkWell(
          onTap: onCountClicked,
          child: SizedBox(
            width: 50,
            child: Row(
              children: [
                Container(color: Colors.red.withOpacity(0.3) , width: 0.5,),
                SizedBox(
                  width: 49.5,
                  child: Visibility(
                    visible: !identical(taskItemWithLevel.taskLevel, TaskLevel.TWO) ,
                    child: Center(
                    child: Text(childrenLength,
                      style: kTextTheme.bodyText2,
                    ),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),

      )
  );
}

/// Shows a Text Field in two cases :
/// 1. A new item
/// 2. In case an item needs to be updated.
Widget getNewIItemTextField(TaskItemWithLevel taskItemWithLevel,
    Function(String string) onItemAddedCallBack) =>
    Padding(
      key: Key('${taskItemWithLevel.taskItem.priority}'),
      padding:  EdgeInsets.symmetric(horizontal: taskItemWithLevel.taskItem.isNewItem ? 15 : 0),
      child: TextField(
        autofocus : true,
        controller: TextEditingController(text: taskItemWithLevel.taskItem.isNewItem ? '' : taskItemWithLevel.taskItem.title),
        style:kTextTheme.bodyText1,

        onSubmitted: (itemtitle){
          onItemAddedCallBack(itemtitle) ; } ,
      ),
    );


Widget getTextOrTextFieldBasedOnAction(TaskItemWithLevel taskItemWithLevel,
     Function() onItemClicked,
    Function(String string) onItemAddedCallBack){
  return taskItemWithLevel.taskItem.isToBeChanged ? getNewIItemTextField(taskItemWithLevel, onItemAddedCallBack) :
  GestureDetector(
      onTap: onItemClicked,
      child : Text(taskItemWithLevel.taskItem.title, style: taskItemWithLevel.taskItem.isCompleted ? kTextTheme.overline : kTextTheme.bodyText1,)
  );
}
