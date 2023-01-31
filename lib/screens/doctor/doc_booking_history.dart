import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Doc_booking_history extends StatefulWidget {
  const Doc_booking_history({Key? key}) : super(key: key);

  @override
  State<Doc_booking_history> createState() => _Doc_booking_historyState();
}

class _Doc_booking_historyState extends State<Doc_booking_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child:
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('booking').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount:snapshot.data!.docs.length,
                        itemBuilder: (context,index) {
                          return
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:ListTile(
                                      title:Text(snapshot.data!.docs[index]['patient_name'].toUpperCase()),
                                      subtitle: Text(snapshot.data!.docs[index]['date'].toString()),
                                      trailing: snapshot.data!.docs[index]['status'] == 'accepted' ? Container(decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text("Accepted",style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          )):
                                      snapshot.data!.docs[index]['status'] == 'pending'?
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text('Pending',style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          )):
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text('Rejected',style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ))
                                  )
                              ),
                            );
                        }
                    );
                  }
                  else{
                    return Text("Something went wrong....");
                  }


                }
              ),
            ),
          )
        ],
      )
    );
  }
}
