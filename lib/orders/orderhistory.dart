import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orderhistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle stylemajor = GoogleFonts.koHo(color: Colors.white);
    TextStyle styleminor = GoogleFonts.koHo(color: Colors.grey.shade600);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.grey.shade800, Colors.black])),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc('orderhistory')
            .collection('orderhistory')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, i) {
                  DocumentSnapshot doc = snapshot.data.docs[i];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.black,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(doc['date'].toDate().toString()),
                                )),
                            Expanded(
                              flex: 3,
                              child: Table(
                                columnWidths: {0: FlexColumnWidth(0.5)},
                                children: [
                                  TableRow(
                                    children: [
                                      Text('Name:', style: styleminor),
                                      Text(doc['name'], style: stylemajor),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('Number:', style: styleminor),
                                      Text(doc['number'], style: stylemajor),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('Location:', style: styleminor),
                                      Text(doc['location'], style: stylemajor),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('PreferedSize:', style: styleminor),
                                      Text(
                                        doc['preferedsize'],
                                        style: stylemajor,
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('HeightWeight:', style: styleminor),
                                      Text(doc['heightweight'],
                                          style: stylemajor),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('OrderDetails:', style: styleminor),
                                      Text(doc['orderdetails'].toString(),
                                          style: stylemajor),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
