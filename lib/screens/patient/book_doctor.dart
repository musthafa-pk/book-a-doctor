
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_doctorbooking/screens/doctor/doc_profile.dart';
import 'package:online_doctorbooking/screens/loginpage.dart';
import 'package:online_doctorbooking/screens/patient/booked_view.dart';
import 'package:online_doctorbooking/screens/patient/booking_history.dart';
import 'package:online_doctorbooking/screens/patient/doc_profile_for_user.dart';
import 'package:online_doctorbooking/utiliteis/constents.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class Book_doctor extends StatefulWidget {
  const Book_doctor({Key? key}) : super(key: key);

  @override
  State<Book_doctor> createState() => _Book_doctorState();
}

class _Book_doctorState extends State<Book_doctor> {



  TimeOfDay? book_time;

  getdata()async{
    final SharedPreferences user_preferences =
    await SharedPreferences.getInstance();
    var id = await user_preferences.getString("id");
    var lists= await FirebaseFirestore.instance.collection('login').get();
    lists.docs.forEach((element) {
      if(element.id==id){
       print(element.data()['name']);

       setState(() {
         username=element.data()['name'];
         useremail=element.data()['username'];
       });
      }
    });
  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

 void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }



  var username ;
  var useremail;

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
        initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.blue,
        drawer: Container(
          width: MediaQuery.of(context).size.width/1.5,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(),
                  accountName: Text(username ?? ""), accountEmail:Text(useremail?? '')),
              Divider(
                color: Colors.black,
              ),

              InkWell(
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      RigistraionPage()),(Route<dynamic>route)=>false);
                },
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Booking_history(),));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: ListTile(
                      title: Text('Booking History',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                      trailing:Icon(Icons.history),
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  //sign out code
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: ListTile(
                    title: Text('Settings',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    trailing:Icon(Icons.settings),
                  ),
                ),
              ),
              InkWell(
                onTap: ()async{
                  var sharedprefrence = await SharedPreferences.getInstance();
                  await sharedprefrence.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      RigistraionPage()),(Route<dynamic>route)=>false);


                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: ListTile(
                    title: Text('Logout',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    trailing:Icon(Icons.logout),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Doctors',icon: Icon(Icons.person),),
              Tab(text: 'History',icon: Icon(Icons.history),),
              Tab(text: 'Bookings',icon: Icon(Icons.app_registration),),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
        ),
        body: TabBarView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
            color: Colors.blue,
              ),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search Doctor', suffixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('doctor').snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Doc(),));
                                  },
                                  leading: CircleAvatar(backgroundImage: NetworkImage('https://images.smiletemplates.com/uploads/screenshots/102/0000102721/powerpoint-template-icons-b.jpg',)),
                                  title: Text(snapshot.data!.docs[index]['name']),
                                  subtitle: Text(snapshot.data!.docs[index]['specialisation']),
                                  trailing: booked==false?ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                        primary: Colors.green
                                    ),
                                    onPressed: ()async{
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context,setState) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.blue,
                                                  scrollable: true,
                                                  title: Text('Save Your Slot',style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  content:Column(
                                                    children: [
                                                      Container(
                                                        height: 250,
                                                        width: 250,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Column(
                                                          children: [

                                                            Expanded(
                                                              child: SfDateRangePicker(
                                                                onSelectionChanged: _onSelectionChanged,
                                                                backgroundColor: Colors.white,
                                                                initialSelectedRange: PickerDateRange(
                                                                    DateTime.now().subtract(Duration(days: 4)),
                                                                    DateTime.now().add(Duration(days: 3))
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: InkWell(
                                                                onTap: ()async{
                                                                  book_time = await showTimePicker(context: context, initialTime:TimeOfDay.now() );
                                                                  setState(() {

                                                                  });
                                                                },
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white
                                                                    ),
                                                                    child:
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(book_time == null ?'Pick Time':book_time!.format(context).toString(),style: TextStyle(
                                                                          color: Colors.black
                                                                      ),),
                                                                    )),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  actions: [
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: (){
                                                                FirebaseFirestore.instance.collection('booking').add({
                                                                  'doc_id':snapshot.data!.docs[index].id,
                                                                  'time':book_time!.format(context).toString(),
                                                                  'date':_selectedDate.toString(),
                                                                  'status':status.toString(),
                                                                  'patient_name':username.toString(),
                                                                  'doc_name':snapshot.data!.docs[index]['name']},);
                                                                Navigator.pop(context);
                                                              },
                                                              style:ElevatedButton.styleFrom(
                                                                  primary: Colors.green
                                                              ),
                                                              child: Text("Save",style: TextStyle(
                                                                  color: Colors.white
                                                              ),)),
                                                          ElevatedButton(onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                              style:ElevatedButton.styleFrom(
                                                                  primary: Colors.red
                                                              ),
                                                              child: Text('Discard',style: TextStyle(
                                                                  color: Colors.white
                                                              ),)),
                                                        ],
                                                      ),
                                                    )
                                                  ],

                                                );
                                              }
                                          );
                                        },
                                      );

                                    },
                                    child: Text('Book Now',style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ):
                                  ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                        primary: Colors.red
                                    ),
                                    onPressed: ()async{
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Are you sure to cancel?'),
                                            actions: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      child: Text('Yes',style: TextStyle(
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    ),
                                                    InkWell(
                                                      onTap:(){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No',style: TextStyle(
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Cancel',style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    )),
                                  ),
                                ),
                              ),
                            );
                          }
                      );

                    }else{
                      return Text("Something went wrong...");
                    }

                  }
                ),
              )
            ],
              ),
            ),
            Booking_history(),
            Booked_list_view(),
          ],
        ),
      ),
    );
  }
}
