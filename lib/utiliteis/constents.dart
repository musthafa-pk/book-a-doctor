import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_doctorbooking/screens/patient/book_doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController doc_name = TextEditingController();
TextEditingController doc_email = TextEditingController();
TextEditingController doc_password = TextEditingController();
TextEditingController doc_passwordconfirm = TextEditingController();
TextEditingController doc_specialisation = TextEditingController();
TextEditingController doc_location = TextEditingController();
TextEditingController doc_qualification = TextEditingController();
TextEditingController user_name = TextEditingController();
TextEditingController user_email = TextEditingController();
TextEditingController user_password = TextEditingController();
TextEditingController user_passwordconfirm = TextEditingController();

bool rbtn = false;
bool male = false;
bool female = false;

String? usertype;

// keys
final formkeydoctor = GlobalKey<FormState>();
final formkeyuser = GlobalKey<FormState>();
//colors
Color bookingbtn = Color.fromRGBO(0, 100, 0, 1);
Color acceptbtn = Color.fromRGBO(0, 100, 0, 1);
Color rejectbtn = Color.fromRGBO(255, 0, 0, 1);

//booking page
bool booked = false;
var time;

//sharedprefrence

get_doc_details() async {
  final SharedPreferences prefrence = await SharedPreferences.getInstance();
  await prefrence.setString(doc_email.toString(), doc_email.text);
  await prefrence.setString(doc_password.toString(), doc_password.text);
  await prefrence.setString(doc_name.toString(), doc_name.text);
  await prefrence.setString(
      doc_qualification.toString(), doc_qualification.text);
  await prefrence.setString(
      doc_specialisation.toString(), doc_specialisation.text);
  await prefrence.setString(doc_location.toString(), doc_location.text);

}

get_user_details() async {
  // final SharedPreferences user_preferences =
  //     await SharedPreferences.getInstance();
  // await user_preferences.setString(user_name.text, user_name.text);
  // await user_preferences.setString(user_email.text, user_email.text);
  // await user_preferences.setString(user_password.text, user_password.text);
  // await user_preferences.setString(usertype.toString(), usertype.toString());
}

//usercreation
Future<bool?>create_doctor() async {
  try {
    final doctors = await FirebaseFirestore.instance.collection('doctor').add({
      'email': doc_email.text,
      'password': doc_password.text,
      'name': doc_name.text,
      'qualification': doc_qualification.text,
      'specialisation': doc_specialisation.text,
      'location': doc_location.text,
      'type': 'doctor'
    });
   var doctorid= await FirebaseFirestore.instance.collection('login').add({
      'username': doc_email.text,
      'password': doc_password.text,
      'name':doc_name.text,
      'type': 'doctor',
     'id':doctors.id,
    });

    final SharedPreferences user_preferences =
    await SharedPreferences.getInstance();
    await user_preferences.setString("id", doctors.id);
    await user_preferences.setString('type','doctor' );
    await user_preferences.setString('name',doc_name.text);
    await user_preferences.setString('email', doc_email.text);
    await user_preferences.setString('specialised',doc_specialisation.text);
    await user_preferences.setString('qualification',doc_qualification.text);

    return true;


  } on Exception catch (e) {
    // TODO
  }
}

Future<bool?>create_patient() async {
  try {
    var patients =
        await FirebaseFirestore.instance.collection('patient').add({
      'email': user_email.text,
      'password': user_password.text,
      'name': user_name.text,
      'type': 'user'
    });


   var patient = await FirebaseFirestore.instance.collection('login').add({
      'username': user_email.text,
      'password': user_password.text,
      'name':user_name.text,
      'type': 'user',
     'id':patients.id,
    });



    final SharedPreferences user_preferences =
    await SharedPreferences.getInstance();
    await user_preferences.setString("id", patients.id);
    await user_preferences.setString('type','user' );
    // await user_preferences.setString(user_email.text, user_email.text);
    // await user_preferences.setString(user_password.text, user_password.text);
    // await user_preferences.setString(usertype.toString(), usertype.toString());
    return true;

  } catch (e) {}
}
var docid;
var docstatus;
var status = 'pending';
var url;

