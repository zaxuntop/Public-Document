import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/message.dart';

class Trash extends StatefulWidget {
  final List<TodoList> trashList;

  const Trash({super.key, required this.trashList,});

  @override
  State<Trash> createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  late bool isCheckBox2; // 삭제 리스트 체크 여부

  @override
  void initState() {
    super.initState();
    isCheckBox2 = false; // true:체크 , false:미체크
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '삭제한 일정',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
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
                          isCheckBox2 = widget.trashList[index].action; // 체크박스 클릭 여부
                          setState(() {  });
                        },
                        ),
                      Expanded(
                        child: ListTile(
                          leading: Image.asset(widget.trashList[index].imagePath),
                          title: Text(widget.trashList[index].contents),
                          subtitle: Text(' 날짜: ${widget.trashList[index].date.toString().split(' ')[0]}'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton
            (onPressed: () {
              if(isCheckBox2 == true){ // 체크박스가 true면 경고 함수 실행
              buttonDialog();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              '삭 제',
              style: TextStyle(
                color: Colors.black,
              ),
              )
            ),
          ),
        ],
      ),
        // drawer: DrawerMenu(
        // imaportantList: imaportantList,
        // trashList: trashList,
        // ),
    );
  } //build
    buttonDialog(){
      Get.defaultDialog(
        title: '중요!',
        middleText: '해당 일정을 정말 삭제하시겠습니까?\n' '(되돌릴 수 없습니다.)',
        backgroundColor: Colors.yellow,
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () => Get.back(), 
            child: Text('아니오')
            ),
          TextButton(
            onPressed: () {
              if(isCheckBox2 == true){
                widget.trashList.removeWhere((checkRemove) => checkRemove.action == true,);
              }
              Get.back();
              setState(() {  });
            }, 
            child: Text('예')
            ),
        ]
      );
    }

}