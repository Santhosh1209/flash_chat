import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chatscreen.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance; // final is used to make sure that it's value can't be changed later
  // NOTE : _ is used before a function/variable to make it private
  late String email; // late allows us to define the string without initializing it
  late String passwd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // y axis (for column) - other way around for rows
          crossAxisAlignment: CrossAxisAlignment.stretch, // x axis (for column) - other way around for rows
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
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color : Colors.black54),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder( // changing the box to a curved one
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder( // default outer colour
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder( // when we click on it
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
                passwd=value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(color : Colors.black54),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      final newUser = await auth.createUserWithEmailAndPassword(
                          email: email,
                          password: passwd); // using properties of firebase auth, we create an account in the FUTURE, which is why we use the async and await methods and then store it in 'newUser'
                      if (newUser != Null) // ie., registration is complete
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
                          {
                            return ChatScreen();
                          },
                          ),);
                        }
                    }
                    catch(e) // try and catch block is used to ensure only valid registrations take place
                    {
                      print((e)); // print the error that occurs
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}