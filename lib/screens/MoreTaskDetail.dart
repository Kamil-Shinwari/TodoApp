// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart' as msg;
import 'package:mailer/smtp_server/gmail.dart';
import 'package:todo_app_fyp/screens/MainScreenWithBottomAppbar.dart';
import 'package:todo_app_fyp/screens/utils.dart';
import 'package:todo_app_fyp/services/cloudFirestore.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MoreTaskDetailScreen extends StatefulWidget {
  final String title;
  final String description;

  const MoreTaskDetailScreen(
      {super.key, required this.title, required this.description});

  @override
  State<MoreTaskDetailScreen> createState() => _MoreTaskDetailScreenState();
}

class _MoreTaskDetailScreenState extends State<MoreTaskDetailScreen> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();

  DateTime dateTime = DateTime.now();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Uint8List? images;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings IOSinitializationSettings =
        DarwinInitializationSettings();
    const InitializationSettings initializtionSetting = InitializationSettings(
        android: androidInitializationSettings,
        iOS: IOSinitializationSettings,
        macOS: null,
        linux: null);

    flutterLocalNotificationsPlugin.initialize(
      initializtionSetting,
    );
  }

  showNotification() async {
    if (widget.title.isEmpty || widget.description.isEmpty) {
      return;
    }
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Notificationss", "Notify Me",
            importance: Importance.high);

    const DarwinNotificationDetails Iosnotificationdetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: Iosnotificationdetails);
    // flutterLocalNotificationsPlugin.show(
    //     01, _title.text.toString(), _desc.text.toString(), notificationDetails);

    tz.initializeTimeZones();
    final tz.TZDateTime scheduleAt = tz.TZDateTime.from(dateTime, tz.local);

    flutterLocalNotificationsPlugin.zonedSchedule(
        01, widget.title, widget.description, scheduleAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
    sendgmail();
    log("btn clicked");
  }

  Future<void> sendgmail() async {
    try {
        var userEmail ='kamilkhanz759@gmail.com';
        // var password = 'ugspyuwkpjntafoy';
        // var smtp_server = gmail(userEmail, password);
        msg.Message message= msg.Message()
        ..subject ='To do App Notification'
        ..text =widget.title
        ..from = msg.Address(userEmail.toString());
        message.recipients.add(userEmail);
        var smtpServer = gmailSaslXoauth2(userEmail, 'hjxpkgsyvhaxzasy');
      await msg.send(message, smtpServer);
        

        
        
    }catch(e){
log(e.toString());
    }
  }

  // sendEmail() async {
  //   final Email email = Email(
  //     body: widget.description,
  //     subject: widget.title,
  //     recipients: ["kamilkhanz759@gmail.com"],
  //     isHTML: false,
  //   );
  //   await FlutterEmailSender.send(email).then((value){
  //     log("email send");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = utils().getScreenSize();
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.030,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.red,
                  )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    images == null
                        ? Stack(
                            children: [
                              Image.network(
                                "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png",
                                height: size.height / 8,
                              ),
                              Positioned(
                                right: -10,
                                bottom: -10,
                                child: IconButton(
                                    onPressed: () async {
                                      Uint8List? list =
                                          await utils().pickImage();
                                      if (list != null) {
                                        setState(() {
                                          images = list;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.add_a_photo_outlined)),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              Image.memory(
                                images!,
                                height: size.height / 8,
                              ),
                              Positioned(
                                right: -10,
                                bottom: -10,
                                child: IconButton(
                                    onPressed: () async {
                                      Uint8List? list =
                                          await utils().pickImage();
                                      if (list != null) {
                                        setState(() {
                                          images = list;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.add_a_photo_outlined)),
                              )
                            ],
                          ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Date",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _date,
                                  decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                          onTap: () async {
                                            final DateTime? newlySelectedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: dateTime,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2095));

                                            if (newlySelectedDate == null) {
                                              return;
                                            }
                                            setState(() {
                                              dateTime = newlySelectedDate;
                                              _date.text =
                                                  "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                            });
                                          },
                                          child: Icon(Icons.calendar_month)),
                                      border: OutlineInputBorder(),
                                      hintText: "Date"),
                                ),
                              ),

                              // Container(

                              //     // color: Colors.orange,
                              //     // padding: EdgeInsets.all(15),
                              //     height: 70,
                              //     child: TextField(
                              //       controller:
                              //           dateinput, //editing controller of this TextField
                              //       decoration: InputDecoration(
                              //           suffixIcon: Icon(Icons.calendar_today),
                              //           border:
                              //               OutlineInputBorder() //icon of text field

                              //           ),
                              //       readOnly:
                              //           true, //set it true, so that user will not able to edit text
                              //       onTap: () async {
                              //         DateTime? pickedDate =
                              //             await showDatePicker(
                              //                 context: context,
                              //                 initialDate: DateTime.now(),
                              //                 firstDate: DateTime(
                              //                     2000), //DateTime.now() - not to allow to choose before today.
                              //                 lastDate: DateTime(2101));

                              //         if (pickedDate != null) {
                              //           print(
                              //               pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              //           String formattedDate =
                              //               DateFormat('dd-MM-yyyy')
                              //                   .format(pickedDate);
                              //           print(
                              //               formattedDate); //formatted date output using intl package =>  2021-03-16
                              //           //you can implement different kind of Date Format here according to your requirement

                              //           setState(() {
                              //             dateinput.text =
                              //                 formattedDate; //set output date to TextField value.
                              //           });
                              //         } else {
                              //           print("Date is not selected");
                              //         }
                              //       },
                              //     )),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Container(
                                    //     height: 70,
                                    //     child: TextField(
                                    //       controller:
                                    //           timeinput, //editing controller of this TextField
                                    //       decoration: InputDecoration(
                                    //         suffixIcon: Icon(Icons
                                    //             .timer), //icon of text field
                                    //         border: OutlineInputBorder(),
                                    //         // /label text of field
                                    //       ),
                                    //       readOnly:
                                    //           true, //set it true, so that user will not able to edit text
                                    //       onTap: () async {
                                    //         TimeOfDay? pickedTime =
                                    //             await showTimePicker(
                                    //           initialTime: TimeOfDay.now(),
                                    //           context: context,
                                    //         );

                                    //         if (pickedTime != null) {
                                    //           print(pickedTime.format(
                                    //               context)); //output 10:51 PM
                                    //           DateTime parsedTime =
                                    //               DateFormat.jm().parse(
                                    //                   pickedTime
                                    //                       .format(context)
                                    //                       .toString());
                                    //           //converting to DateTime so that we can further format on different pattern.
                                    //           print(
                                    //               parsedTime); //output 1970-01-01 22:53:00.000
                                    //           String formattedTime =
                                    //               DateFormat('HH:mm:ss')
                                    //                   .format(parsedTime);
                                    //           print(
                                    //               formattedTime); //output 14:59:00
                                    //           //DateFormat() is from intl package, you can format the time on any pattern you need.

                                    //           setState(() {
                                    //             timeinput.text =
                                    //                 formattedTime; //set the value of text field.
                                    //           });
                                    //         } else {
                                    //           print("Time is not selected");
                                    //         }
                                    //       },
                                    //     )),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: _time,
                                        decoration: InputDecoration(
                                            suffixIcon: InkWell(
                                                onTap: () async {
                                                  final TimeOfDay?
                                                      selectedTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now());
                                                  if (selectedTime == null) {
                                                    return;
                                                  }
                                                  _time.text =
                                                      "${selectedTime.hour}:${selectedTime.minute}:${selectedTime.period.toString()}";

                                                  DateTime newDT = DateTime(
                                                      dateTime.year,
                                                      dateTime.month,
                                                      dateTime.day,
                                                      selectedTime.hour,
                                                      selectedTime.minute);
                                                  setState(() {
                                                    dateTime = newDT;
                                                  });
                                                },
                                                child: Icon(Icons.timelapse)),
                                            border: OutlineInputBorder(),
                                            hintText: "Time"),
                                      ),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.060,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: const Text(
                              'Upload',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              await CloudFirestoreClass()
                                  .UploadTaskToDatabase(
                                      title: widget.title,
                                      description: widget.description,
                                      image: images,
                                      date: dateinput.text,
                                      time: timeinput.text,
                                      name: FirebaseAuth
                                          .instance.currentUser!.displayName
                                          .toString())
                                  .then((value) {
                                showNotification();
                                log("btn clicked");
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => AppMainPage(),
                                //     ));
                              });
                            },
                          )),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       final corn = Cron();

                    //       String oldDateStr = dateinput.text;
                    //       String oldTimerStr = timeinput.text;
                    //       final String dateTimeString2 = oldDateStr +" "+oldTimerStr;
                    //       final DateFormat format = new DateFormat("yyyy-MM-dd hh:mm:ss.SSS");
                    //    DateTime newDate = format.parse(dateTimeString2);
                    //    DateFormat newFormat = DateFormat("yyyy-MM-dd hh:mm:ss.SSS");
                    //     DateTime latest = newFormat.parse(DateTime.now().toString());
                    //     log(latest.toString());

                    //       corn.schedule(
                    //           Schedule.parse('*/2 * * * * *'),
                    //           () => {
                    //                  if(latest.isAtSameMomentAs(newDate)){
                    //                   setState(() {
                    //                      latest = newFormat.parse(DateTime.now().toString());
                    //                   }),
                    //       log("both same")
                    //     }
                    //     else if (latest.isBefore(newDate)){
                    //       setState(() {
                    //         latest = newFormat.parse(DateTime.now().toString());
                    //       }),
                    //       log("$latest is befor"),
                    //     }
                    //     else{
                    //       log("$latest is after"),
                    //        setState(() {
                    //                       latest = newFormat
                    //                           .parse(DateTime.now().toString());
                    //                     }),
                    //     }
                    //               });
                    //     },
                    //     child: Text("click me")),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
