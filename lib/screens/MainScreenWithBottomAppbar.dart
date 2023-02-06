
import 'package:flutter/material.dart';
import 'package:todo_app_fyp/canstants.dart';
import 'package:todo_app_fyp/screens/AddTaskScreen.dart';
import 'package:todo_app_fyp/screens/HistoryScreen.dart';
import 'package:todo_app_fyp/screens/TaskList.dart';

class AppMainPage extends StatefulWidget {
  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  int selectedindex = 0;
  List<Widget> pageWidget=[
    AddTaskScreen(),
    TaskShowScreen(),
    HistoryScreenScreen()
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: IndexedStack(
        index: selectedindex,
        children: pageWidget,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedindex,
          backgroundColor: Colors.orange.withOpacity(0.8),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: ((value) {
            setState(() {
              selectedindex = value;
            });
          }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                 
                ),
                label: "AddTask"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt,
                ),
                label: "ShowTask"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: "History"),
           
          ]),
    );
  }
}
