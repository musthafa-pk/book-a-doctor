import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Booking_history extends StatefulWidget {
  const Booking_history({Key? key}) : super(key: key);

  @override
  State<Booking_history> createState() => _Booking_historyState();
}

class _Booking_historyState extends State<Booking_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('booking').snapshots(),
                    builder: (context,snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount:snapshot.data!.docs.length,
                            itemBuilder: (context,index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: ListTile(
                                      title: Text(snapshot.data!.docs[index]['date'].toString()),
                                      subtitle: Text(snapshot.data!.docs[index]['doc_name'].toString()),
                                      trailing:
                                      snapshot.data!.docs[index]['status']=='Accepted'?
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(snapshot.data!.docs[index]['status'].toString(),style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),),
                                          )
                                      ):snapshot.data!.docs[index]['status'] == 'Rejected' ?Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(snapshot.data!.docs[index]['status'].toString(),style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                            ),),
                                          )
                                      ):Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(snapshot.data!.docs[index]['status'].toString(),style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                            ),),
                                          )
                                      )
                                  ),
                                ),
                              );
                            }
                        );
                      }else{
                        return Text('Something went wrong...');
                      }
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
