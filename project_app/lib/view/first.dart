import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/message.dart';
import 'package:project_app/view/drawer.dart';
import 'package:project_app/view/habit.dart';
// 로그인시 가장 먼저 보이는 페이지
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late List<TodoList> todoList; // 전체 일정 리스트
  late DateTime date; // 날짜
  late TextEditingController textEditingController; // 덱스트 필드 컨트롤러
  late DateTime selectedDate; // 선택한 날짜
  late bool isCheckBox; // 체크박스 체크 여부
  late int radioValue; // 라디오 버튼 값
  late String selectDateText; // 선택 날짜 텍스트
  late List<TodoList> imaportantList; // 중요 일정 리스트트

@override
  void initState() {
    super.initState();
    todoList = []; // 할일 리스트 초기화
    date = DateTime.now(); // 지금 날짜로 초기화
    addData(); // 데이터 추가
    textEditingController = TextEditingController(); // 텍스트 필드 컨트롤러 초기화
    selectedDate = DateTime.now(); // 선택 날짜 초기화
    isCheckBox = false; // 체크박스 초기화
    radioValue = 0; // 라디오 버튼 초기화
    selectDateText = ''; // 선택 날짜 텍스트 초기화
    imaportantList = []; // 중요 일정 리스트 초기화
  }

addData(){
  todoList.add(TodoList(imagePath: 'images/food.png', contents: '점심 시키기', date: DateTime.now(), action: false, imaportant: false));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전체 일정 관리'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(onPressed: () {
            Get.to(Habit(imaportantList: imaportantList,));
          },
          icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('images/group.png', width: 50,),
                Image.asset('images/sport.png', width: 50,),
                Image.asset('images/food.png', width: 50,),
                Image.asset('images/shopping.png', width: 50,),
                Image.asset('images/clock.png', width: 50,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('회의'),
                Text('운동'),
                Text('식사'),
                Text('쇼핑'),
                Text('약속'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Radio(
                  value: 0, // 회의 일정
                  groupValue: radioValue, 
                  onChanged: (value) => radioChange(value),
                  ),
                Radio(
                  value: 1, // 운동 일정
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
      
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: '추가할 일정을 입력하세요',
                hintText: '일정을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    dispDatePicker();
                  }, 
                  child: Text('날짜 선택')
                  ),
                  SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () {
                    if(textEditingController.text.trim().isEmpty){
                      Get.snackbar('경고', '일정을 입력하세요', backgroundColor: Colors.redAccent);
                      return;
                    }                    
                    todoList.add(TodoList(
                    imagePath: getRadioValue(), 
                    contents: textEditingController.text, 
                    date: selectedDate, 
                    action: false,
                    imaportant: false),
                    );
                    textEditingController.clear();
                    setState(() {      });
                  }, 
                  child: Text('일정 추가')
                  ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey(todoList[index]),
                    onDismissed: (direction) {
                      todoList.remove(todoList[index]);
                      setState(() {    });
                    },
                    background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.delete_forever_outlined,
                      size: 40,
                      ),
                    ),
                    child: Card(
                      color: todoList[index].action ? Colors.green : Colors.blueGrey,
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
                            width: 55,
                          ),
                          Text(
                            todoList[index].contents,
                          ),
                          Text(' [날짜 : ${todoList[index].date.toString().split(' ')[0]}]'),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              todoList[index].imaportant = !todoList[index].imaportant;
                              if(todoList[index].imaportant == true){
                                imaportantList.add(todoList[index]);
                              }else{
                                imaportantList.remove(todoList[index]);
                              }
                              setState(() {                         });
                            }, 
                            icon: Icon(
                              Icons.star,
                              color: todoList[index].imaportant ? Colors.black : Colors.white,
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
      drawer: DrawerMenu(), 
    );
  } //build

// 라디오 버튼 값 변경 함수
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