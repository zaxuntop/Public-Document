import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/view/first.dart';
//로그인 화면 창
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController idcontroller; // id 입력칸
  late TextEditingController pwcontroller; // pw 입력칸

  @override
  void initState() {
    super.initState();
    idcontroller = TextEditingController();
    pwcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
        '야 너두 To do 할 수 있어\n' 
        "'Log In Now!'",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color.fromARGB(255, 27, 19, 148),
          fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
      ),
      body: Align(
        // alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'images/bottle.jpg',
                fit: BoxFit.cover,
              ),
            ),
        
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    SizedBox(
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 5,
                          )
                        ),
                        child: Image.asset(
                          'images/login2.jpg',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: idcontroller,
                        decoration: InputDecoration(
                          labelText: 'ID를 입력하세요',
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: pwcontroller,
                        decoration: InputDecoration(
                          labelText: 'PW를 입력하세요',
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          checkidpw();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          foregroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '로그인',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkidpw() {
    if(idcontroller.text.trim().isEmpty || pwcontroller.text.trim().isEmpty){
      Get.snackbar('경고', '내용을 입력하지 않았습니다',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2)
      );
    }
    else if (idcontroller.text == 'qw' && pwcontroller.text == '12') {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('환영 합니다'),
            content: Text("야나두님을 확인하였습니다"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAll(FirstPage(),
                    transition: Transition.leftToRight,
                    duration: Duration(seconds: 1),
                    );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('다음', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    } else {
      Get.snackbar('경고', '계정 정보가 틀렸습니다.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2)
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('계정 정보가 아닙니다.'),
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }
}
