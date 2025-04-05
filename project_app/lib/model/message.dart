class Message {
  static String imagePath = ''; // 리스트뷰 이미지 경로
  static String contents = ''; // 텍스트 필드 입력 글자
  static bool action = false; // 리스트뷰 클릭 여부
}

class TodoList{
  final String imagePath; // 이미지 경로
  final String contents;// 입력 글자
  late DateTime date; // 날짜
  late bool action; // 리스트뷰 클릭 여부
  late bool imaportant; // 중요 일정 체크


TodoList(
  {
    required this.imagePath,
    required this.contents,
    required this.date,
    required this.action,
    required this.imaportant,
  }
);

}