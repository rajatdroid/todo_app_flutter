import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/core_constants.dart';
import 'package:flutter_app/models/task_item.dart';
import 'package:flutter_app/models/task_item_with_level.dart';
import 'package:flutter_app/models/todonode.dart';
import 'package:flutter_app/providers/main_todo_list.dart';
import 'package:flutter_app/ui/constants/label_constants.dart';
import 'package:flutter_app/ui/constants/ui_conatnts.dart';
import 'package:flutter_app/ui/custoimwidgets/swipable_list_tile.dart';
import 'package:flutter_app/ui/screens/level_one_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => createExitDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(labelsMap[kKeyHomeTitle]!,
            style: kTextTheme.headline1,),
        ),

        body: const SafeArea(child: HomeStatefulLogic()),
      ),
    );
  }

  Future<bool> createExitDialog(BuildContext context) async{
     return await showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('${labelsMap[kKeyExit]}', style: kTextTheme.bodyText1),
            content: Text('${labelsMap[kKeyExitSure]}', style: kTextTheme.bodyText1),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:   Text('${labelsMap[kKeyExit]}', style: kTextTheme.bodyText2,),
              ),
              ElevatedButton(
                onPressed: () => saveExistingTasksInStorage(context),
                child:  Text('${labelsMap[kKeySave]}', style: kTextTheme.bodyText2),
              ),
            ],
          );
        } );
  }

  saveExistingTasksInStorage(BuildContext context) async{
    Map<String,dynamic> nodeMap = Provider.of<ItemListHome>(context, listen: false).toJson();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(kSharedPrefTaskKey, jsonEncode(nodeMap));
    Navigator.of(context).pop(true);
  }

}

class HomeStatefulLogic extends StatefulWidget {
  const HomeStatefulLogic({Key? key}) : super(key: key);

  @override
  _HomeStatefulLogicState createState() => _HomeStatefulLogicState();
}

class _HomeStatefulLogicState extends State<HomeStatefulLogic> {


  getSavedTaskList() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = sharedPreferences.getString(kSharedPrefTaskKey) ?? '';
    Provider.of<ItemListHome>(context, listen: false).setItemList(ItemListHome.fromJson(jsonDecode(jsonString) as Map<String, dynamic>).taskList);
  }

  @override
  void initState() {
    super.initState();
    getSavedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return  HomeBody();
  }
}


class HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListHome>(
      builder: (context, itemListHomeObj, widget) {

        return RefreshIndicator(

          onRefresh: () async{
            itemListHomeObj.addNewTaskHome(TaskItemWithLevel(taskLevel: TaskLevel.HOME,taskItem: TaskItem(isNewItem: true)));
          },
          child: ReorderableListView.builder(
              itemCount: itemListHomeObj.getTasksForHome().length,
              itemBuilder: (context, index) {

                TaskNode taskNode = itemListHomeObj.getSortedTasklistForHome().asMap()[index]!;
                TaskItemWithLevel taskItemWithLevel = taskNode.parent;

                return getHomeListTileWithGestures(
                  taskItemWithLevel: taskItemWithLevel,
                  childrenLength:  '${taskNode.children.length}',
                  onRightSwiped: (context){ itemListHomeObj.markAKeyItemAsComplete(taskItemWithLevel); },
                  onRightSwipedReverse: (context){ itemListHomeObj.markItemAsUnComplete(taskItemWithLevel); },
                  onLeftSwiped: (context){ itemListHomeObj.deleteKey(taskItemWithLevel); },
                  onItemClicked: (){itemListHomeObj.markItemForUpdate(taskItemWithLevel); },
                  onCountClicked: (){ Navigator.push(context, MaterialPageRoute(builder: (context) =>  LevelOneScreen(parentItem: taskItemWithLevel,))) ;},
                  onItemAddedCallBack: (String string) {
                    taskItemWithLevel.taskItem.title = string;
                    itemListHomeObj.markNewKeyAsAdded(taskItemWithLevel);

                  },
                );
              }, onReorder: (int oldIndex, int newIndex) {
                if(newIndex > oldIndex){
                  itemListHomeObj.changePriorityForIncreasingIndex(oldIndex, newIndex-1, TaskLevel.HOME, null);
                } else if(oldIndex > newIndex){
                  itemListHomeObj.changePriorityForDecreasingIndex(oldIndex, newIndex, TaskLevel.HOME, null);
                }
          },
          ),
        );
      },
    );
  }
}








