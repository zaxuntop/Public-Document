import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/view/first.dart';
import 'view/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // 로컬하려면 타이틀 밑에 로컬라이제이션 사용, 펍스펙.yaml 추가 타이핑 해야함
      localizationsDelegates: [ 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
      getPages: [
        GetPage(
          name: '/first', 
          page: () => FirstPage(),
          ),
      ],
    );
  }
}
