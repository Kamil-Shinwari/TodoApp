import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app_fyp/canstants.dart';
import 'package:todo_app_fyp/screens/MainScreenWithBottomAppbar.dart';
import 'package:todo_app_fyp/screens/TaskDetailScreen.dart';
import 'package:todo_app_fyp/screens/loginScreen.dart';
import 'package:todo_app_fyp/services/authentication.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final themedata = GetStorage();
  @override
  Widget build(BuildContext context) {
    themedata.writeIfNull("darkmode", false);
    bool isdarkMode = themedata.read("darkmode");
    return Scaffold(
      appBar: AppBar(actions: [
        
      
        
        IconButton(onPressed: () async{
        await FirebaseAuth.instance.signOut().then((value) {
          Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen(),));
        });
      }, icon: Icon(Icons.logout))]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailScreen(),));
              },
              child: Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(color:Colors.orange),
                child: Center(
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

              SwitchListTile(
            secondary: Icon(Icons.ac_unit),
            title: Text("Theme"),
            value: isdarkMode,
            onChanged: (value) {
              setState(() {
                isdarkMode = value;
              });
              isdarkMode
                  ? Get.changeTheme(ThemeData.dark())
                  : Get.changeTheme(ThemeData.light());
              themedata.write('darkmode', value);
            },
          ),
        ],
      ),
    );
  }
}