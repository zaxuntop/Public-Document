import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/list.dart';
import 'package:project_app/view/drawer.dart';

class Today extends StatefulWidget {
  const Today({super.key, });

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘 일정',),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.back(result: true); // back할때 변경내용을 감지
            }, 
            icon: Icon(Icons.arrow_back)),
        ],
      ),
      drawer: drawerMenu(
        imaportantList: TotalList.imaportantList, 
        trashList: TotalList.trashList, 
        todayList: TotalList.todayList
        ),
      body: ListView.builder(
        itemCount: TotalList.todayList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey(TotalList.todayList[index].contents),
            onDismissed: (direction) {
              final removeIndex = TotalList.todayList[index];
              TotalList.trashList.add(removeIndex);
              TotalList.todayList.removeAt(index);
              TotalList.todoList.remove(removeIndex);
              Get.snackbar(
                '삭제 완료', 
                '${removeIndex.contents} 일정이 삭제되었습니다',
                );
              setState(() { });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(Icons.delete_rounded,
              size: 35,
              ),
            ),
            child: Card(
              child: ListTile(
                leading: Image.asset(TotalList.todayList[index].imagePath),
                title: Text(TotalList.todayList[index].contents),
                subtitle: Text(TotalList.todayList[index].date.toString().split(' ')[0]),
              ),
            ),
          );
        },
        ),
    );
  }
}