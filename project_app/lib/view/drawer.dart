import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/list.dart';
import 'package:project_app/model/message.dart';
import 'package:project_app/view/first.dart';
import 'package:project_app/view/habit.dart';
import 'package:project_app/view/home.dart';
import 'package:project_app/view/profile.dart';
import 'package:project_app/view/trash.dart';

Drawer drawerMenu({
  required List<TodoList> imaportantList,
  required List<TodoList> trashList,
  required List<TodoList> todayList,
  required BuildContext context,
  required Future Function() onTodayTap, // 콜백 추가 함수 필요
}) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('images/login2.jpg'),
          ),
          accountName: Text('야나두'),
          accountEmail: Text('yanado@todo.or.kr'),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            '프로필 보기',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Get.back(); // Navigator.pop(context) 대신
            Get.to(Profile());
          },
        ),
        ListTile(
          leading: Icon(Icons.checklist),
          title: Text(
            '전체 일정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Get.back(); 
            Get.to(FirstPage());
          },
        ),
        ListTile(
          leading: Icon(Icons.today),
          title: Text(
            '오늘 일정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () async{
            Navigator.pop(context);
            await onTodayTap(); // first페이지 정의한 onToday 함수 실행행
            // Get.back();
            // Get.to(Today()); 
          },
        ),
        ListTile(
          leading: Icon(Icons.repeat),
          title: Text(
            '중요 일정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Get.back();
            Get.to(Habit(imaportantList: TotalList.imaportantList));
          },
        ),
        ListTile(
          leading: Icon(Icons.remove_circle),
          title: Text(
            '삭제 일정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Get.back();
            Get.to(Trash(trashList: TotalList.trashList));
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            '로그 아웃',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () => Get.offAll(() => Home()),
        ),
      ],
    ),
  );
}
