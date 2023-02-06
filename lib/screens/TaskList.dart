import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_format.dart';
DateTime date = DateTime.now();
String time = "${date.hour}:${date.minute}:${date.second}";
class TaskShowScreen extends StatefulWidget {
  const TaskShowScreen({super.key});

  @override
  State<TaskShowScreen> createState() => _TaskShowScreenState();
}

class _TaskShowScreenState extends State<TaskShowScreen> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('UploadTask')
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  if(date==doc['date'] && time==doc["time"]){
                    sendEmail(doc['title'], doc['description']);
                    log("send email");
                  }
                  return Column(
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
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(doc['url']),
                                        fit: BoxFit.cover),
                                    border: Border.all(color: Colors.orange)),
                              )),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 5),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Date :              ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            ),
                                            Expanded(
                                              child: Text(
                                                doc['date'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Description : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            ),
                                            Expanded(
                                              child: Text(
                                                doc['description'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Task Title : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            ),
                                            Expanded(
                                              child: Text(
                                                doc['title'],
                                                style: TextStyle(
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(

                                            onTap:()async{
                                              sendEmail(doc['title'],doc['description']);
                                              log("btn press");
                                            },
                                            // onTap: () async{



                                            //   // final Email email = Email(
                                            //   //   body: doc['title'],
                                            //   //   subject: doc['description'],
                                            //   //   recipients: [
                                            //   //     'kamilshinwari131@gmail.com'
                                            //   //   ],
                                                
                                            //   //   isHTML: false,
                                            //   // );

                                            //   // await FlutterEmailSender.send(
                                            //   //     email).then((value) {
                                            //   //       log("send");
                                            //   //     });

                                            //   log(index.toString());

                                            // },
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child: Center(
                                                  child: Text(
                                                "Completed",
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
                      ),
                    ],
                  );
                });
          } else {
            return Text("No data");
          }
        },
      ),
    ));
  }


}

Future sendEmail(String subject , String description) async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const service_id = 'service_o6cerdb';
  const templateId = 'template_lwu2bjc';
  const userId = 'BhIRZQHZWu9qW60Mx';
  const privatekey ='WejwxGG58hwvJniu84G7V';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json',},
      body: json.encode({
        "service_id": service_id,
        "template_id": templateId,
        "user_id": userId,
        "accessToken":privatekey,
        "template_params": {
          "user_name": "kamil",
          "user_subject": subject,
          "user_message": description,
          "user_email": "kamilshinwari4@gmail.com",
        }
      }));
      log(response.body);
      log(response.statusCode.toString());
  return response.statusCode;
}
