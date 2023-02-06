import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:todo_app_fyp/screens/MoreTaskDetail.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  SpeechToText speechToText = SpeechToText();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool islistening = false;
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.060,
                    width: MediaQuery.of(context).size.height * 0.090,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.height * 0.090,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoreTaskDetailScreen(
                                    title: titleController.text,
                                    description: descriptionController.text),
                              ));
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange.withOpacity(0.7))),
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Row(children: [
        //   Expanded(child:Column(children: [
        //      Padding(
        //           padding: const EdgeInsets.symmetric(
        //             horizontal: 8.0,
        //           ),
        //           child: Align(
        //               alignment: Alignment.topLeft,
        //               child: Text(
        //                 "Date",
        //                 style: TextStyle(
        //                     fontSize: 16, fontWeight: FontWeight.bold),
        //               )),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(20),
        //                 border:
        //                     Border.all(color: Colors.orange.withOpacity(0.7))),
        //             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //               child: TextField(
        //                 // controller: titleController,
        //                 decoration: InputDecoration(
        //                   suffixIcon: Icon(Icons.calendar_month),
        //                     border: InputBorder.none,
        //                     hintText: "01/05/2023",
        //                     hintStyle: TextStyle(
        //                         color: Colors.grey,
        //                         fontWeight: FontWeight.bold)),
        //               ),
        //             ),
        //           ),
        //         ),

        //   ],) ),

        //    Expanded(
        //         child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(
        //             horizontal: 8.0,
        //           ),
        //           child: Align(
        //               alignment: Alignment.topLeft,
        //               child: Text(
        //                 "Time",
        //                 style: TextStyle(
        //                     fontSize: 16, fontWeight: FontWeight.bold),
        //               )),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(20),
        //                 border:
        //                     Border.all(color: Colors.orange.withOpacity(0.7))),
        //             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //               child: TextField(

        //                 // controller: titleController,
        //                 decoration: InputDecoration(
        //                   suffixIcon:Icon(Icons.schedule),
        //                     border: InputBorder.none,
        //                     hintText: "06:58",
        //                     hintStyle: TextStyle(
        //                         color: Colors.grey,
        //                         fontWeight: FontWeight.bold)),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     )),
        // ],),

        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withOpacity(0.8))),
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8,
                controller: descriptionController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "description",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: islistening,
          duration: Duration(milliseconds: 2000),
          glowColor: Colors.green,
          repeatPauseDuration: Duration(microseconds: 100),
          showTwoGlows: true,
          repeat: true,
          child: GestureDetector(
              onTapDown: (details) async {
                if (!islistening) {
                  var available = await speechToText.initialize();
                  if (available) {
                    setState(() {
                      islistening = true;
                      if (x == 0) {
                        speechToText.listen(
                          onResult: (result) {
                            setState(() {
                              titleController.text = result.recognizedWords;
                            });
                          },
                        );
                      } else if (x == 1) {
                        speechToText.listen(
                          onResult: (result) {
                            setState(() {
                              descriptionController.text =
                                  result.recognizedWords;
                            });
                          },
                        );
                      } else {
                        speechToText.stop();
                      }
                    });
                  }
                }
              },
              onTapUp: (details) {
                setState(() {
                  islistening = false;
                  speechToText.stop();
                  x++;
                });
              },
              child: CircleAvatar(
                child: Icon(
                  islistening ? Icons.mic : Icons.mic_none,
                  size: 30,
                ),
                radius: 35,
              ))),
    );
  }
}
