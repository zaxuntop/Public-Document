import 'package:flutter/material.dart';
import 'package:project_app/model/message.dart';

class Habit extends StatefulWidget {
 final List<TodoList> imaportantList; // 중요 일정 리스트
  const Habit({super.key, required this.imaportantList});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('중요 일정'),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.imaportantList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Image.asset(widget.imaportantList[index].imagePath),
                title: Text(widget.imaportantList[index].contents),
                subtitle: Text(' 날짜 : ${widget.imaportantList[index].date.toString().split(' ')[0]}'),
              ),
            );
          },),
      ),
    );
  }
}