import 'package:flutter/material.dart';

class Booked_list_view extends StatefulWidget {
  const Booked_list_view({Key? key}) : super(key: key);

  @override
  State<Booked_list_view> createState() => _Booked_list_viewState();
}

class _Booked_list_viewState extends State<Booked_list_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context,index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(
                      title: Text('Date'),
                      subtitle: Text('Name of Doctor'),
                      trailing: Icon(Icons.verified_user_outlined),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
