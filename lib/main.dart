import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_doctorbooking/screens/doctor/appoinment_status.dart';
import 'package:online_doctorbooking/screens/doctor/doc_booking_history.dart';
import 'package:online_doctorbooking/screens/doctor/doc_profile.dart';
import 'package:online_doctorbooking/screens/loginpage.dart';
import 'package:online_doctorbooking/screens/patient/book_doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var id = preferences.getString('id') ?? "null";
  var type = preferences.getString('type') ?? 'null';
  runApp( MyApp(id: id,type: type,));
}

class MyApp extends StatelessWidget {
  String id;
  String type;
   MyApp({required this.id,required this.type});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Book a Doctor',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: type == 'user' ? Book_doctor():type == 'doctor'?Appointment_status():
      RigistraionPage(),
    );
  }
}

