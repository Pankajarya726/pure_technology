import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pankaj_pure_technlogy_test/employee_screen.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
      appId: '1:454530283089:ios:190b57074464c5b7d06a70',
      apiKey: 'AIzaSyA70IIgINpKI132a2i_kiK1n9ilINgKolc',
      projectId: 'pure-technology',
      messagingSenderId: '732312949335',
      databaseURL: 'https://pure-technology-default-rtdb.firebaseio.com/',
    )
        : const FirebaseOptions(
      appId: '1:732312949335:android:9897216661588679f44912',
      apiKey: 'AIzaSyA70IIgINpKI132a2i_kiK1n9ilINgKolc',
      messagingSenderId: '732312949335',
      projectId: 'pure-technology',
      databaseURL: 'https://pure-technology-default-rtdb.firebaseio.com/',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const EmployeeScreen(),
    );
  }
}

