import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solosadmin/solosadmindrawer/solosadmindrawer.dart';

class Customerrecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Text('CUSTOMER RECORDS',
            style: GoogleFonts.koHo(
                fontWeight: FontWeight.bold, fontSize: size.width * .06)),
      ),
      drawer: SolosAdminDrawer(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.grey.shade800, Colors.black])),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('records')
                .doc('customerrecords')
                .collection('customerrecords')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    separatorBuilder: (context, i) => Divider(
                          color: Colors.grey.shade700,
                          thickness: 1,
                        ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      DocumentSnapshot doc = snapshot.data.docs[i];
                      return ListTile(
                        title: Text(doc['name']),
                        subtitle: Text(doc['number']),
                        trailing: Text(doc['location']),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
