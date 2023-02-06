import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height *0.024
          ,),
          Text("Enter your email",style: TextStyle(color: Colors.orange,fontSize: 22,fontWeight: FontWeight.bold),),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
             Container(
              height: 50,
              width: MediaQuery.of(context).size.width *0.5,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: ()async {
                 await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
                  Fluttertoast.showToast(msg: "we have send you email to recover your password");
                 });
                },
              )),
        ]),
      ),
    );
  }
}