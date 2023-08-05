import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'chatscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Notes : Async means that some function is asynchronous and you might need to wait a bit to get its result. Await literally means - wait here until this function is finished and you will get its return value. Future is a type that 'comes from the future' and returns value from your asynchronous function.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  late String email;
  late String passwd;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // duration of the toast is short
      gravity: ToastGravity.BOTTOM, // toast will appear at the bottom of the screen.
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  email=value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.black54), // colour of hint text
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)), // changing the box to  curved one
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0), // default outer colour
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0), // selected outer colour
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true, // this helps us hide the password
              onChanged: (value) {
                setState(() {
                  passwd=value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your password.',
                hintStyle: TextStyle(color: Colors.black54),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
              style: TextStyle(color: Colors.black),

            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try { // If the login is successful, the if block will be executed
                      final user = await auth.signInWithEmailAndPassword(email: email, password: passwd);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ChatScreen();
                          }),
                        );
                      }
                      setState(() {
                        loading = false; // loading is set to false if the login in unsuccessful
                      });
                    } catch (e) {
                      print(e);
                      showToast("Invalid email or password"); // Show toast on login failure
                      setState(() {
                        loading = false;
                      });
                    }
                    },
                  minWidth: 200.0,
                  height: 42.0,
                  child: loading ? CircularProgressIndicator(
                    color: Colors.white,) : Text('Log In',),
                  // If loading is true, the button shows a CircularProgressIndicator in white color, indicating that the login process is ongoing.
                  // If loading is false, the button shows the text "Log In".
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

