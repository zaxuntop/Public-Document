import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/message.dart';
import 'package:project_app/view/habit.dart';
import 'package:project_app/view/home.dart';
import 'package:project_app/view/profile.dart';
import 'package:project_app/view/today.dart';
import 'package:project_app/view/trash.dart';
// 드로워 바 페이지
class DrawerMenu extends StatelessWidget {
  final List<TodoList> imaportantList;
  final List<TodoList> trashList;

  const DrawerMenu({super.key, required this.imaportantList, required this.trashList});

  @override
  Widget build(BuildContext context) {
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
            onTap: () => Get.to(Profile()),
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text(
              '전체 일정',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Get.to(Today()),
          ),
          ListTile(
            leading: Icon(Icons.repeat),
            title: Text(
              '중요 일정',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Get.to(Habit(imaportantList: imaportantList,));
            }, 
          ),
          ListTile(
            leading: Icon(Icons.remove_circle),
            title: Text(
              '삭제한 일정',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Get.to(Trash(trashList: trashList,)),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              '로그 아웃',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Get.off(Home()),
          ),
        ],
      ),
    );
  }
}
