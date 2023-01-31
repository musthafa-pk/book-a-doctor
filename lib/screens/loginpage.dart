
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_doctorbooking/screens/doctor/doc_registration.dart';
import 'package:online_doctorbooking/screens/patient/book_doctor.dart';
import 'package:online_doctorbooking/screens/patient/doc_profile_for_user.dart';
import 'package:online_doctorbooking/screens/patient/user_registration.dart';
import 'package:online_doctorbooking/utiliteis/constents.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doctor/appoinment_status.dart';

class RigistraionPage extends StatefulWidget {
  const RigistraionPage({Key? key}) : super(key: key);

  @override
  State<RigistraionPage> createState() => _RigistraionPageState();
}

class _RigistraionPageState extends State<RigistraionPage> {
 dynamic? usertype;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white,Colors.blue]
              )
            ),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,width: 200,
                          child: Lottie.asset('asset/115070-doctor.json')),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('Login',style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child:
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 10),
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: 'E-mail',
                                suffixIcon: Icon(Icons.attach_email),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 10,top: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius:BorderRadius.circular(25),
                          ),
                          child:
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 10),
                            child: TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: Icon(Icons.remove_red_eye),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(onPressed: ()async{
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Book_doctor(),));
                         var col_login = await FirebaseFirestore.instance.collection('login').get();
                         col_login.docs.forEach((element)async {
                           var user = element.data()['username'];
                           //print(user);
                           var pass = element.data()['password'];
                           if(user == email.text && pass == password.text){
                             setState(() {
                               usertype = element.data()['type'];
                             });
                             try{
                               if(usertype == 'user'){
                                 final SharedPreferences user_preferences =
                                     await SharedPreferences.getInstance();
                                 await user_preferences.setString("id", element.data()['id']);
                                 await user_preferences.setString('type','user' );
                                 await user_preferences.setString('name',element.data()['name']);
                                 await user_preferences.setString('email',element.data()['username']);
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => Book_doctor(),));

                               }
                               if(usertype == 'doctor'){
                                 final SharedPreferences user_preferences =
                                 await SharedPreferences.getInstance();
                                 await user_preferences.setString("id", element.data()['id']);
                                 await user_preferences.setString('type','doctor' );
                                 await user_preferences.setString('name',element.data()['name']);
                                 await user_preferences.setString('email',element.data()['username']);
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment_status(),));
                               }

                             }catch(e){

                             }
                           }
                         });
                        },
                            child: Text('Login')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",style: TextStyle(
                              fontSize: 16
                            )),
                            InkWell(
                              onTap: ()async{
                                 await showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    title: Text('Register as'),
                                    content:Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            usertype='Doctor';
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Doc_registration(),));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child:
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text('Doctor',style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                              ),),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            usertype='Customer';
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => User_registration(),));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child:
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text('Customer',style: TextStyle(
                                                  color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),);
                                },
                                 );
                              },
                              child: Text("SignUp",style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
