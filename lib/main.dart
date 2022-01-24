import 'package:flutter/material.dart';
import 'package:flutter_app/providers/main_todo_list.dart';
import 'package:flutter_app/ui/constants/label_constants.dart';
import 'package:flutter_app/ui/constants/ui_conatnts.dart';
import 'package:flutter_app/ui/screens/home_screen.dart';
import 'package:flutter_app/ui/screens/onboarding.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<ItemListHome>(
      create: (BuildContext context) => ItemListHome(taskList: []),
      child: MaterialApp(
        title: labelsMap['home_screen_title']!,
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
            fontFamily: 'Source Serif Pro',
        ),
        home: OnBoardingScreen(),
      ),
    );
  }
}
