import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudFirestoreClass{
    Future<String> uploadImageToDatabase(
      {required Uint8List image,}) async {
    Reference storageref =
        FirebaseStorage.instance.ref().child('Task');
    UploadTask uploadTask = storageref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future UploadTaskToDatabase({required String title, required String description ,
  required String name,
  required Uint8List? image,
  required String date, required String time
  } ) async{
    if(title !="" && description !="" && image!=null && date !="" && time !="") {
        String url = await uploadImageToDatabase(image: image,);
        try{
           await FirebaseFirestore.instance
            .collection("UploadTask")
            .add({
              "title":title,
              "description":description,
              "url":url,
              "date":date,
              "time":time,
              "uid":FirebaseAuth.instance.currentUser!.uid,
              "name":name,
            });
        }catch(e){
          log(e.toString());
        }
    }
  }
}