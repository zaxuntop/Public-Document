import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:project_app/view/first.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          onPressed: () {
            Get.off(() => FirstPage());
          }, 
          icon: Icon(Icons.arrow_back)),
      ),
      
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
               backgroundImage: AssetImage('images/profile.jpg'),
               radius: 120,
               ),
            ),
            Text(
              '야나두',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text(
                '즐거운 마음으로 일정을 관리합니다\n'
                '여러분도 함께 해요!!\n'
                '모두 좋은 일만 생기시길~\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '2025년 4월 4일',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}