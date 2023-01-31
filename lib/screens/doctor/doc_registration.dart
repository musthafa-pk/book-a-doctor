import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_doctorbooking/screens/doctor/appoinment_status.dart';
import 'package:online_doctorbooking/screens/doctor/doc_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utiliteis/constents.dart';

class Doc_registration extends StatefulWidget {
  const Doc_registration({Key? key}) : super(key: key);

  @override
  State<Doc_registration> createState() => _Doc_registrationState();
}

class _Doc_registrationState extends State<Doc_registration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SingleChildScrollView(
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
            child: Form(
              key: formkeydoctor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:BorderRadius.only(
                              bottomLeft: Radius.circular(350),
                            )
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/3.5,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 75),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(350)
                              )
                          ),
                        ),
                        Positioned(
                          top: 75,
                          right: 25,
                          child: Text('Welcome Doctor',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35
                          ),),
                        ),

                        Positioned(
                          top: 120,
                          right: 25,
                          child: Container(
                              decoration:BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)
                              ),
                              child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Setup Your Account...,',style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                              )),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15,top: 25),
                      child:
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                        ),child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            controller: doc_name,
                          validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Please fill the field';
                              }
                              return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Full Name'
                          ),
                      ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            controller: doc_email,
                            validator: (value) {
                              if(value == null ||value.isEmpty){
                                return 'Please fill the field';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email'
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            controller: doc_password,
                            validator: (value) {
                              if(value==null || value.isEmpty){
                                return 'Please fill this field';
                              }
                              if(value.length<6){
                                return 'Password mustbe 7 charecters';
                              }
                              return null;

                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            controller: doc_passwordconfirm,
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Please fll this field';
                              }
                              return null;

                            },
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Please fill this field';
                              }
                              return null;

                            },
                            controller: doc_specialisation,
                            decoration: InputDecoration(
                              hintText: 'Specialised',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Please fill this field';
                              }
                              return null;
                            },
                            controller: doc_location,
                            decoration: InputDecoration(
                              hintText: 'Location',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            controller: doc_qualification,
                            validator: (value) {
                              print(value);
                              if(value== null||value.isEmpty){
                                return 'Please fill this field';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Qualification',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: ()async{
                        if(formkeydoctor.currentState!.validate()){
                          get_doc_details();

                         var result = await create_doctor();
                         if(result == true){
                           await Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment_status(),));

                         }

                        }

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Doc_profile(),));
                      },
                          child: Text('Sign Up',style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
