
import 'package:flutter/material.dart';
import 'package:online_doctorbooking/controlers/controlerpage1.dart';
import 'package:online_doctorbooking/screens/patient/book_doctor.dart';
import 'package:online_doctorbooking/utiliteis/constents.dart';

class User_registration extends StatefulWidget {
  const User_registration({Key? key}) : super(key: key);

  @override
  State<User_registration> createState() => _User_registrationState();
}

class _User_registrationState extends State<User_registration> {
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
            child: Form(
              key: formkeyuser,
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
                        child: Text('Welcome...',style: TextStyle(
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
                        controller: user_name,
                        validator: (value) {
                          if(value==null || value.isEmpty){
                            return 'Please fill this field';
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
                          controller: user_email,
                          validator: (value) {
                            if(value == null ||value.isEmpty){
                              return 'Please fill this field';
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
                          controller: user_password,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "pleas fill this field";
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

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(25),
                  //         color: Colors.white
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 15,right: 15),
                  //       child: TextFormField(
                  //         controller: user_passwordconfirm,
                  //         validator: (value) {
                  //           if(value == null || value.isEmpty){
                  //             return 'pleas fill this field';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: InputDecoration(
                  //           hintText: 'Confirm Password',
                  //           border: InputBorder.none,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Gender:  Male'),
                          Radio(value: true, groupValue:male,
                              onChanged: (value){
                              if(male==true){
                                setState(() {
                                  male=false;
                                });
                              }
                              if(male==false){
                                setState(() {
                                  male=true;
                                });
                              }
                              print(male);
                              }),
                          Text('FeMale'),
                          Radio(value: true, groupValue:female,
                              onChanged: (value){
                                  if(female==true){
                                    setState(() {
                                      female=false;
                                    });
                                  }else{
                                    setState(() {
                                      female=true;
                                    });
                                  }
                              }),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(onPressed: ()async{
                      create_patient();
                      if(formkeyuser.currentState!.validate()){

                       await Navigator.push(context, MaterialPageRoute(builder: (context) => Book_doctor(),));
                      }
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
      );
  }
}
