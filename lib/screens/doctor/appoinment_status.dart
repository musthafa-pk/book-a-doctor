import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_doctorbooking/screens/doctor/doc_booking_history.dart';
import 'package:online_doctorbooking/screens/doctor/doc_profile.dart';
import 'package:online_doctorbooking/screens/loginpage.dart';
import 'package:online_doctorbooking/utiliteis/constents.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment_status extends StatefulWidget {
  const Appointment_status({Key? key}) : super(key: key);

  @override
  State<Appointment_status> createState() => _Appointment_statusState();
}

class _Appointment_statusState extends State<Appointment_status> {

  @override
  void initState() {
    // TODO: implement initState
    getdetails();
    super.initState();
  }
  var name;
  var email;
  getdetails()async{
    var data = await SharedPreferences.getInstance();
    name = data.getString('name');
    email = data.getString('email');
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        drawer: Container(
          width: MediaQuery.of(context).size.width/1.5,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(),
                  accountName: Text(name.toString()),
                  accountEmail: Text(email.toString()),),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Doc_profile(),));
                },
                child: ListTile(
                  title: Text('Profile',style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  trailing: Icon(Icons.person),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: ()async{
                  var sharedprefrence = await SharedPreferences.getInstance();
                  sharedprefrence.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      RigistraionPage()),(Route<dynamic>route)=>false);
                },
                child: ListTile(
                  title: Text('Logout',style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  trailing: Icon(Icons.logout),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          bottom:TabBar(
            tabs: [
              Tab(text: 'Booking',icon: Icon(Icons.app_registration,),),
              Tab(text: 'History',icon: Icon(Icons.history),),
            ],
          )
        ),
        body:TabBarView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('booking').snapshots(),
                      builder: (context,AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                            child:
                            ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context,index) {
                                  var tokenno=index+1;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child:snapshot.data.docs[index]['status'].toString() == "pending" ?  Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Text(snapshot.data.docs[index]['patient_name'].toUpperCase(),style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 32
                                                ),),
                                                Text(snapshot.data.docs[index]['date'].toString()),
                                                Text(snapshot.data.docs[index]['time'].toString()),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      ElevatedButton(onPressed: ()async{
                                                        docid = snapshot.data.docs[index].id;

                                                        // status = 'accepted';
                                                        print(docid);
                                                       await FirebaseFirestore.instance.collection('booking').doc(docid).update({'status':"accepted"});
                                                      },
                                                          style: ElevatedButton.styleFrom(
                                                            primary: acceptbtn,
                                                          ),
                                                          child:Text('Accept',style: TextStyle(
                                                              color: Colors.white
                                                          ),)),
                                                      ElevatedButton(onPressed: ()async{
                                                        docid = snapshot.data.docs[index].id;
                                                        await FirebaseFirestore.instance.collection('booking').doc(docid).update({'status':'rejected'});

                                                      },
                                                          style: ElevatedButton.styleFrom(
                                                            primary: rejectbtn,
                                                          ),
                                                          child:Text('Reject',style: TextStyle(color: Colors.white),)),
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ):snapshot.data.docs[index]['status'].toString() == "rejected" ? Container():Container(),
                                  );
                                }
                            ),
                          );
                        }
                        else{
                          return Text('Something Wrong...');
                        }
                      }
                    ),
                  )
                ],
              ),
            ),
            Doc_booking_history()
          ],
        ),
      ),
    );
  }
}
