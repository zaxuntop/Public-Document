import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/controller.dart';
import 'package:project_app/model/list.dart';
import 'package:project_app/model/message.dart';
import 'package:project_app/view/habit.dart';
import 'package:project_app/view/home.dart';
import 'package:project_app/view/profile.dart';
import 'package:project_app/view/trash.dart';
// 드로우바를 위젯으로 변경하여 다른페이지에서 불러쓰게 함
Drawer drawerMenu({
  required List<TodoList> imaportantList,
  required List<TodoList> trashList,
  required List<TodoList> todayList,
  required BuildContext context,
  required Future Function() onTodayTap, // 오늘 일정 콜백 추가 함수 필요
  required VoidCallback onRefresh, // 삭제 일정 콜백
}) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('images/login2.jpg'),
          ),
          accountName: Text(UserController.userName),
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
            Get.toNamed('/first');
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
            await onTodayTap(); // first페이지 정의한 onTodayTap 함수 실행 위해 async,await 사용
            // Get.back();   //(기존 코드)
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
          // 복구 기능 문제로 변경한 코드
          onTap: () async{
            Navigator.pop(context); // 드로워 닫기
              final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => Trash(trashList: TotalList.trashList)),
                );
                  if (result == true) {
                  onRefresh(); // 셋스테이트가 불가능해 삭제 일정 콜백 함수 만듬
                  }
            // Get.back(); //(기존 코드)
            // Get.to(Trash(trashList: TotalList.trashList));
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
