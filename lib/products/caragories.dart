import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solosadmin/products/editcatagory.dart';
import 'package:solosadmin/products/products.dart';
import 'package:solosadmin/solosadmindrawer/solosadmindrawer.dart';

import 'addcatagory.dart';

class Catagories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Text('CATAGORIES',
            style: GoogleFonts.koHo(
                fontWeight: FontWeight.bold, fontSize: size.width * .06)),
      ),
      drawer: SolosAdminDrawer(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addcatagory()));
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          )),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey.shade800, Colors.black])),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('catagories')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      DocumentSnapshot doc = snapshot.data.docs[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.black,
                          elevation: 5,
                          shadowColor: Colors.grey.shade700,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 6,
                                child: ListTile(
                                  title: Text(doc['name'],
                                      style: GoogleFonts.koHo(
                                          fontWeight: FontWeight.w600)),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Product(
                                                  catagoryname: doc['name'],
                                                )));
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: MaterialButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Editcatagory(
                                                name: doc['name'],
                                                i1: doc['image1'],
                                                i2: doc['image2'],
                                                time: doc['time'],
                                                docname: doc.id,
                                              );
                                            }));
                                          },
                                          child: Text('EDIT',
                                              style: GoogleFonts.koHo())),
                                    ),
                                    Flexible(
                                        child: MaterialButton(
                                            onPressed: () {
                                              showAlertDialog(context, doc.id);
                                            },
                                            child: Text('DELETE',
                                                style: GoogleFonts.koHo(
                                                    color: Colors.red)))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }

  showAlertDialog(BuildContext context, docid) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("DELETE THIS CATAGORY?",
          style: GoogleFonts.koHo(fontWeight: FontWeight.bold)),
      content: Text("Would you like to delete this catagory?"),
      actions: [
        TextButton(
          child: Text(
            "Yes, Delete",
            style: GoogleFonts.koHo(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('createshop')
                .doc(docid)
                .delete();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                content: Text(
                  'CATAGORY DELETED',
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
