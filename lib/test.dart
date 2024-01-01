
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  // This widget is the root of your application.
  String id;
  TestPage({Key? key, required this.id});
  @override
  Widget build(BuildContext context) {
     
     print("Room id is");
     print(id);
    return Scaffold(
      body: Container(color: Colors.purple,),
    );
  }
}