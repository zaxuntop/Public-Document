import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/message.dart';

class Habit extends StatefulWidget {
 final List<TodoList> imaportantList; // 중요 일정 리스트
  const Habit({super.key, required this.imaportantList}); // 생성자에 리콰이어 추가

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '중요 일정',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.imaportantList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(widget.imaportantList[index]),
              onDismissed: (direction) {
                
                Get.snackbar(
                  ' 중요 일정', 
                  '${widget.imaportantList[index].contents} 일정을 해제했습니다',
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  );
                widget.imaportantList[index].imaportant = false;
                widget.imaportantList.remove(widget.imaportantList[index]);
                setState(() {    });
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.delete,
                size: 50,
                ),
              ),
              child: Card(
                child: ListTile(
                  leading: Image.asset(widget.imaportantList[index].imagePath),
                  title: Text(widget.imaportantList[index].contents),
                  subtitle: Text(' 날짜 : ${widget.imaportantList[index].date.toString().split(' ')[0]}'),
                ),
              ),
            );
          },),
      ),
    );
  } //build


}