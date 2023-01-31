import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_doctorbooking/utiliteis/constents.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doc_registration.dart';

class Doc_profile extends StatefulWidget {
  const Doc_profile({Key? key}) : super(key: key);

  @override
  State<Doc_profile> createState() => _Doc_profileState();
}

class _Doc_profileState extends State<Doc_profile> {

  @override
  void initState() {
    // TODO: implement initState
    get_full_data();
    getDetails();
    super.initState();
  }
  String? name;
  String? specialised;
  String? qualification;
  String ? password;
  String ? phonenumber;
  String? email;
  String? doctorid;

  get_full_data()async{
    var data = await  SharedPreferences.getInstance();
    setState(() {
      name = data.getString('name');
      specialised =  data.getString('specialised');
      qualification = data.getString('qualification');
      doctorid = data.getString('doctorsid');
      email = data.getString('email');
    });

  }



  File? imageFile;
  final picker = ImagePicker();


String? name1;
String? email2;
String? spe;
  getDetails()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var type = await sharedPreferences.getString('type');

    var id = await sharedPreferences.getString("id");

    var documentSnapshot = await FirebaseFirestore.instance.collection(type!).doc(id).get();
    var d = await documentSnapshot.data();
    name1 = d!["name"];
    email2 = d!["email"];
    spe = d!["specialisation"];

    setState(() {

    });
    print(d!["name"]);
  }

  Future pickImage() async {
    dynamic pickedFile = await picker.pickImage(source: ImageSource.camera);

    if(pickedFile != null){

        imageFile = File(pickedFile.path);
        //uploader(imageFile!);
        Reference reference =  await  FirebaseStorage.instance.ref().child("imges/${imageFile!.path}");
        TaskSnapshot uploadTask = await reference.putFile(imageFile!);
        String url = await reference.getDownloadURL();
        print("picket urls ${url}");

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       var id = await sharedPreferences.getString("id");
        print("picket id ${id}");
        FirebaseFirestore.instance.collection('doctor')
            .doc(id).update({'profile_image':url});

        setState(() {
        });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                          Positioned(
                            top: 80,
                            left: 75,
                            child: InkWell(
                              onTap: () {
                                pickImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        name1.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        email2.toString(),
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(
                      spe.toString(),
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            decoration:
                                InputDecoration(label: Text(name.toString())),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              decoration:
                                  InputDecoration(label: Text(email.toString())),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              decoration:
                                  InputDecoration(label: Text('Password')),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              decoration: InputDecoration(
                                  label: Text(specialised.toString())),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              decoration:
                                  InputDecoration(label: Text(qualification.toString())),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              decoration:
                                  InputDecoration(label: Text('Phone Number')),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance.collection('doctor')
                              .doc(url).update({'profile_image':url});
                          print(url);
                          Navigator.pop(context);
                        },
                      child: Icon(Icons.check,color: Colors.green,),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
