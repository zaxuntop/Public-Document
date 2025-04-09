import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/list.dart';
import 'package:project_app/model/message.dart';
import 'package:project_app/view/first.dart';
// 중요 일정 관리 페이지
class Habit extends StatefulWidget {
 final List<TodoList> imaportantList; // 중요 일정 리스트(처음에 모델로 list 안만든 페이지)
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
          '- 중요 일정 -',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        // 뒤로 가기 버튼을 기본 페이지(FirstPage)로 고정
        leading: IconButton(
          onPressed: () {
            Get.off(() => FirstPage());
          }, 
          icon: Icon(Icons.arrow_back)),        
      ),
      body: Center(
        child: // 중요 일정 페이지 빈 공간일시 텍스트
        TotalList.imaportantList.isEmpty ? Text(
          "' 중요 일정이 없습니다. '",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          ) :
        ListView.builder(
          itemCount: widget.imaportantList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(widget.imaportantList[index]),
              onDismissed: (direction) {
                // 삭제 경고 스낵바
                Get.closeAllSnackbars();
                Get.snackbar(
                  '중요 일정', 
                  '${widget.imaportantList[index].contents} 일정을 해제했습니다',
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  );
                widget.imaportantList[index].imaportant = false; // 중요 일정 해제함
                widget.imaportantList.remove(widget.imaportantList[index]); // 중요 리스트에서만 삭제
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
              // 중요 일정 리스트 화면
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