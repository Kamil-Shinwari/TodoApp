import 'package:flutter/material.dart';
import 'package:todo_app_fyp/screens/test.dart';

class HistoryScreenScreen extends StatefulWidget {
  const HistoryScreenScreen({super.key});

  @override
  State<HistoryScreenScreen> createState() => _HistoryScreenScreenState();
}

class _HistoryScreenScreenState extends State<HistoryScreenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Task Completed",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Task Title : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        Text(
                          "Buy Books ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Description : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        Expanded(
                          child: Text(
                            "You have to buy one History book, one Science book ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Task assign by : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        Expanded(
                          child: Text(
                            "Asif baloch ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "Remove",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
