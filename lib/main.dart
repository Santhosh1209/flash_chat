import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'welcomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //To use Firebase services, we need to initialize the Firebase app by calling Firebase.initializeApp() before using any Firebase features.
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

 class FlashChat extends StatelessWidget {
   const FlashChat({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       theme: ThemeData.dark().copyWith(
         textTheme: TextTheme(
           bodyLarge: TextStyle( color: Colors.black54
           )
         )
       ),
       home: WelcomeScreen(),
     );
   }
 }
