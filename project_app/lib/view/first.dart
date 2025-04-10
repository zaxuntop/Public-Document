import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_app/model/list.dart';
import 'package:project_app/model/message.dart';
import 'package:project_app/view/drawer.dart';
import 'package:project_app/view/habit.dart';
import 'package:project_app/view/today.dart';
// 로그인시 가장 먼저 보이는 전체 일정 페이지(기본페이지)
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late List<TodoList> todoList; // 전체 일정 리스트
  late DateTime date; // 날짜
  late TextEditingController textEditingController; // 텍스트 필드 컨트롤러
  late DateTime selectedDate; // 선택한 날짜
  late bool isCheckBox; // 체크박스 체크 여부
  late int radioValue; // 라디오 버튼 값
  late String selectDateText; // 선택 날짜 텍스트


@override
  void initState() {
    super.initState();
    todoList = TotalList.todoList; // 전체 일정 리스트
    if(todoList.isEmpty && TotalList.trashList.isEmpty){
    addData(); // 데이터 추가(전체 및 삭제 일정이 비어있을시)
    }
    date = DateTime.now(); // 지금 날짜로 초기화
    textEditingController = TextEditingController(); // 텍스트 필드 컨트롤러 초기화
    selectedDate = DateTime.now(); // 선택 날짜 초기화
    isCheckBox = false; // 체크박스 초기화
    radioValue = 0; // 라디오 버튼 초기화
    selectDateText = ''; // 선택 날짜 텍스트 초기화
  }

addData(){ // 허수 데이터 삽입
  todoList.add(TodoList(
    imagePath: 'images/food.png', 
    contents: '안돌이지돌이다래미한숨바우 철수 식사', // 입력칸에 현실적으로 가장 긴 지명 및 약속 사용
    date: DateTime.now(),
    action: false, 
    imaportant: false)
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '- 전체 일정 관리 -',
        style: GoogleFonts.nanumBrushScript(
          fontSize: 35,
          fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        // 중요 일정 페이지 앱바 아이콘
        actions: [
          IconButton(onPressed: () {
            Get.to(Habit(imaportantList: TotalList.imaportantList,),
            transition: Transition.rightToLeft,
            duration: Duration(seconds: 1),
            ); 
          },
          icon: Icon(Icons.import_contacts),
          ),
        ],
      ),
      //드로우바 메뉴
      drawer: drawerMenu(
        imaportantList: TotalList.imaportantList, 
        trashList: TotalList.trashList, 
        todayList: TotalList.todayList,
        context: context,
        onTodayTap: () async{ 
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Today(),));
          if(result == true){
            setState(() {      });
          }
        },
        onRefresh: (){setState(() { });}

        ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 8,),
            //전체 일정 카테고리 종류 이미지
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('images/group.png', width: 40,),
                Image.asset('images/sport.png', width: 40,),
                Image.asset('images/food.png', width: 40,),
                Image.asset('images/shopping.png', width: 40,),
                Image.asset('images/clock.png', width: 40,),
              ],
            ),
            // 전체 일정 카테고리 종류 텍스트
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('회의'),
                Text('활동'),
                Text('식사'),
                Text('쇼핑'),
                Text('약속'),
              ],
            ),
            // 전체 일정 카테고리 라디오 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Radio(
                  value: 0, // 회의 일정
                  groupValue: radioValue, 
                  onChanged: (value) => radioChange(value),
                  ),
                Radio(
                  value: 1, // 활동 일정
                  groupValue: radioValue, 
                  onChanged: (value) => radioChange(value),
                  ),
                Radio(
                  value: 2, // 식사 일정
                  groupValue: radioValue, 
                  onChanged: (value) => radioChange(value),
                  ),
                Radio(
                  value: 3, // 쇼핑 일정
                  groupValue: radioValue, 
                  onChanged: (value) => radioChange(value),
                  ),
                Radio(
                  value: 4, // 약속 일정
                  groupValue: radioValue, 
                  onChanged: (value) => radioChange(value),
                  ),
              ],
            ),
            // 텍스트 필드 입력 칸
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: '추가할 일정을 입력하세요',
                hintText: '일정을 입력하는 곳입니다.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              maxLines: 1,
              maxLength: 20,  // 가장 긴 지명 13글자 감안
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton( // 날짜 선택 버튼
                  onPressed: () {
                    dispDatePicker();
                  }, 
                  child: Text('날짜 선택',
                  style: TextStyle(
                    color: Colors.redAccent
                  ),
                  ),
                ),
                  SizedBox(width: 20,),
                // 일정 추가 버튼
                ElevatedButton(
                  onPressed: () {
                    if(textEditingController.text.trim().isEmpty){
                      Get.snackbar('경고', '일정을 입력하세요', backgroundColor: Colors.redAccent);
                      return;
                    } // 객체, 여러 리스트 공유 위해 newtodo 만듬(Todolist, todaylist)
                     final newtodo = TodoList(
                      imagePath: getRadioValue(), 
                      contents: textEditingController.text, 
                      date: selectedDate, 
                      action: false, 
                      imaportant: false
                    );
                    todoList.add(newtodo);

                    if(selectedDate.toString().substring(0,10) == date.toString().substring(0,10)){
                      TotalList.todayList.add(newtodo);
                    }
                    // todoList.add(TodoList(
                    // imagePath: getRadioValue(), 
                    // contents: textEditingController.text, 
                    // date: selectedDate, 
                    // action: false,
                    // imaportant: false
                    // ),
                    // );
                    textEditingController.clear();
                    setState(() {      });
                  }, 
                  child: Text('일정 추가',
                  style: TextStyle(
                    color: Colors.redAccent
                  ) ,
                  ),
                ),
              ],
            ),
            // 일정 리스트뷰
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey(todoList[index]),
                    onDismissed: (direction) {
                      TotalList.trashList.add(todoList[index]);
                      final removeIndex = todoList[index]; //삭제후 index 참조 위해 변수 지정
                      todoList.removeAt(index);
                      TotalList.todayList.remove(removeIndex); 
                      // TotalList.todayList.remove(TotalList.todayList[index]);
                      // todoList.remove(todoList[index]);
                      Get.closeAllSnackbars(); // 여러 일정 삭제시 경고창 연속 등장 방지
                      Get.snackbar(
                        '삭제', 
                        '${removeIndex.contents} 일정을 삭제했습니다',
                        backgroundColor: Colors.redAccent,
                        duration: Duration(milliseconds: 1500),
                        );
                      setState(() {    });
                    },
                    background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(Icons.delete_forever_outlined,
                      size: 35,
                      ),
                    ),
                    // 카드 체크박스시 색상 변함
                    child: Card(
                      color: todoList[index].action ? Colors.lightGreen : Colors.grey,
                      child: Row(
                        children: [
                          Checkbox(
                            value: todoList[index].action,
                            onChanged: (value) {
                              todoList[index].action = value!;
                              setState(() { });
                            },
                          ),
                          Image.asset(
                            todoList[index].imagePath,
                            width: 40,
                          ),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todoList[index].contents,
                                softWrap: true,
                                maxLines: 2,
                              ),
                              Text(
                                ' [날짜: ${todoList[index].date.toString().split(' ')[0]}]',
                              ),
                            ],
                          ),
                          Spacer(),
                          // 중요 일정 표시 아이콘
                          IconButton(
                            onPressed: () {
                              todoList[index].imaportant = !todoList[index].imaportant;
                              if(todoList[index].imaportant == true){
                                TotalList.imaportantList.add(todoList[index]);
                              }else{
                                TotalList.imaportantList.remove(todoList[index]);
                              }
                              setState(() {  });
                            }, 
                            icon: Icon(
                              Icons.star,
                              color: todoList[index].imaportant ? Colors.yellow : Colors.white,
                            ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                ),
              ),
          ],
        ),
      ),
    );
  } //build

// 라디오 버튼 값 변경 함수, 라디오 값은 널러블 가능(하나만 선택하니까), 따라서 ?와 ! 
  radioChange(int? value){
    radioValue = value!;
    setState(() { });
  }

  // 라디오 버튼 함수
 String getRadioValue(){
  switch(radioValue){
    case 0:
    return 'images/group.png';
    case 1:
    return 'images/sport.png';
    case 2:
    return 'images/food.png';
    case 3:
    return 'images/shopping.png';
    case 4:
    return 'images/clock.png';
    default:
    return 'images/group.png';
  }
 }

  // 달력 선택 함수
  dispDatePicker() async{
    // print(date.year);
    int firstYear = date.year -1; // 1년 전 
    int lastYear = date.year +2;  // 2년 후
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Locale('ko', 'KR'),
    );
    if(pickedDate != null){
     selectedDate = pickedDate; //선택 날짜
     selectDateText = '선택하신 날짜는 ${pickedDate.toString().substring(0,10)}입니다.';
    }
    setState(() {   });
  }
 


}