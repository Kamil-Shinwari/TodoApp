import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> SignUpuser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "some error occured";
    if (password != "" && email != "") {
      try {
      await  firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "plz fill all field";
    }
    return output;
  }

  Future<String> SignInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "some error occured";
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
       await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "plz fill all field";
    }
    return output;
  }
}
