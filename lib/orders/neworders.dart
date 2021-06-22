import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Neworders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
              .doc('neworders')
              .collection('neworders')
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
                      child: Dismissible(
                        key: ValueKey(123),
                        confirmDismiss: (direction) {
                          return showAlertDialog(context, doc);
                        },
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.greenAccent.shade700),
                          child: Icon(Icons.move_to_inbox_outlined),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 30),
                        ),
                        child: InkWell(
                          onLongPress: () {
                            showAlertDialogdelete(context, doc);
                          },
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
                                        child: Text(
                                            doc['date'].toDate().toString()),
                                      )),
                                  Expanded(
                                    flex: 3,
                                    child: Table(
                                      columnWidths: {0: FlexColumnWidth(0.5)},
                                      children: [
                                        TableRow(
                                          children: [
                                            Text('Name:', style: styleminor),
                                            Text(doc['name'],
                                                style: stylemajor),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text('Number:', style: styleminor),
                                            Text(doc['number'],
                                                style: stylemajor),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text('Location:',
                                                style: styleminor),
                                            Text(doc['location'],
                                                style: stylemajor),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text('PreferedSize:',
                                                style: styleminor),
                                            Text(
                                              doc['preferedsize'],
                                              style: stylemajor,
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text('HeightWeight:',
                                                style: styleminor),
                                            Text(doc['heightweight'],
                                                style: stylemajor),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text('OrderDetails:',
                                                style: styleminor),
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
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  showAlertDialog(BuildContext context, doc) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("MOVE TO HISTORY?",
          style: GoogleFonts.koHo(fontWeight: FontWeight.bold)),
      content: Text("Would you like to move this order to Order History?"),
      actions: [
        TextButton(
          child: Text(
            "Yes, Move to History",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('orders')
                .doc('orderhistory')
                .collection('orderhistory')
                .add({
              'name': doc['name'],
              'number': doc['number'],
              'location': doc['location'],
              'preferedsize': doc['preferedsize'],
              'heightweight': doc['heightweight'],
              'orderdetails': doc['orderdetails'],
              'date': doc['date']
            });
            FirebaseFirestore.instance
                .collection('records')
                .doc('customerrecords')
                .collection('customerrecords')
                .add({
              'name': doc['name'],
              'number': doc['number'],
              'location': doc['location']
            });
            FirebaseFirestore.instance
                .collection('orders')
                .doc('neworders')
                .collection('neworders')
                .doc(doc.id)
                .delete();

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                content: Text(
                  'MOVED TO HISTORY',
                  style: GoogleFonts.koHo(
                      color: Colors.greenAccent.shade400,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
        TextButton(
          child: Text(
            "No",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogdelete(BuildContext context, doc) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("DELETE ORDER?",
          style: GoogleFonts.koHo(fontWeight: FontWeight.bold)),
      content: Text("Would you like to delete this Order?"),
      actions: [
        TextButton(
          child: Text(
            "Yes, Delete this Order",
            style: GoogleFonts.koHo(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('orders')
                .doc('neworders')
                .collection('neworders')
                .doc(doc.id)
                .delete();

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                content: Text(
                  'ORDER DELETED',
                  style: GoogleFonts.koHo(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
        TextButton(
          child: Text(
            "No",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
