import 'package:flutter/material.dart';
import 'package:project_app/model/message.dart';

class Trash extends StatefulWidget {
  final List<TodoList> trashList;

  const Trash({super.key, required this.trashList});

  @override
  State<Trash> createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('삭제 일정'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.trashList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Checkbox(
                        value: widget.trashList[index].action, 
                        onChanged: (value) {
                          widget.trashList[index].action = value!;
                          setState(() {  });
                        },
                        ),
                      Expanded(
                        child: ListTile(
                          leading: Image.asset(widget.trashList[index].imagePath),
                          title: Text(widget.trashList[index].contents),
                          subtitle: Text(' 날짜 : ${widget.trashList[index].date.toString().split(' ')[0]}'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton
          (onPressed: () {
            //
          }, 
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('삭제'),
          )
          ),
        ],
      ),
    );
  }
}