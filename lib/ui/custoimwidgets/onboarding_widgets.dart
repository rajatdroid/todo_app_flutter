import 'package:flutter/material.dart';
import 'package:flutter_app/ui/constants/label_constants.dart';
import 'package:flutter_app/ui/constants/ui_conatnts.dart';

Widget getPage(int pageNum){
  return Container(
    margin: const EdgeInsets.only(top: 80),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getUpperText(pageNum),
        Visibility(visible : getBottomTextKey(pageNum).isNotEmpty ,child: const SizedBox(height: 20)),
        Visibility(
            visible : getBottomTextKey(pageNum).isNotEmpty ,
            child: Text(getBottomTextKey(pageNum), style: kTextTheme.bodyText1,)),
        const SizedBox(height: 40,),
        Expanded(child: Image.asset(getImageAsset(pageNum))),
      ],
    ),
  );
}

Widget getUpperText(int pageNum){

  Widget textRow = Row() ;

  switch (pageNum) {

    case 1:{
      textRow =  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Flexible(child  : Text(labelsMap[kKeyOnBoardText11]!, style: kTextTheme.bodyText1,)),
          Flexible(child  : Text(labelsMap[kKeyPriority]!, style: kTextTheme.caption,)),
        ],);
      break;
    }

    case 2:{
      textRow = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Flexible(child  : Text(labelsMap[kKeyTapAndHold]!, style: kTextTheme.caption,)),
          Flexible(child  : Text(labelsMap[kKeyOnBoardText21]!, style: kTextTheme.bodyText1,)),
        ],);
      break;
    }

    case 3:{
      textRow =  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Flexible(child  : Text(labelsMap[kKeyClickRowCount]!, style: kTextTheme.caption,)),
          Flexible(child: Text(labelsMap[kKeyOnBoardText32]!, style: kTextTheme.bodyText1,)),
        ],);
      break;
    }

    case 4:{
      textRow =  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Flexible(child  : Text(labelsMap[kKeyTapListTile]!, style: kTextTheme.caption,)),
          Flexible(child  : Text(labelsMap[kKeyOnBoardText41]!, style: kTextTheme.bodyText1,)),
        ],);
      break;
    }

    case 5:{
      textRow =  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Flexible(child  : Text(labelsMap[kKeySwipeLeft]!, style: kTextTheme.caption,)),
          Flexible(child  : Text(labelsMap[kKeyOnBoardText61]!, style: kTextTheme.bodyText1,)),
        ],);
      break;
    }

    case 6:{
      textRow =  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Flexible(child  : Text(labelsMap[kKeySwipeRight]!, style: kTextTheme.caption,)),
          Flexible(child  : Text(labelsMap[kKeyOnBoardText51]!, style: kTextTheme.bodyText1,)),
        ],);
      break;
    }
  }

  return textRow;
}

String getBottomTextKey(int pageNum){

  String key = labelsMap[kKeySwipeRight]!;

  switch (pageNum){
    case 1: {
      key = labelsMap[kKeyOnBoardText12]!;
      break;
    }

    case 2: {
      key =labelsMap[ kKeyOnBoardText22]!;
      break;
    }

    case 3: {
      key = labelsMap[kKeyOnBoardText31]!;
      break;
    }

    case 4: {
      key = '';
      break;
    }

    case 5: {
      key = '';
      break;
    }

    case 6: {
      key = '';
      break;
    }

  }
  return key;
}


String getImageAsset(int pageNum){

  String image = 'assets/images/list1.png';

  switch (pageNum){
    case 1: {
      image ='assets/images/list1.png';
      break;
    }

    case 2: {
      image ='assets/images/list1.png';
      break;
    }

    case 3: {
      image ='assets/images/list2.png';
      break;
    }

    case 4: {
      image ='assets/images/edit title.png';
      break;
    }

    case 5: {
      image ='assets/images/swipeleft.png';
      break;
    }

    case 6: {
      image ='assets/images/swiperight.png';
      break;
    }

  }
  return image;
}