import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'productadd.dart';
import 'productedit.dart';

class Product extends StatefulWidget {
  final String catagoryname;

  Product({this.catagoryname});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle textsize = GoogleFonts.koHo(fontSize: size.width * .04);
    TextStyle h1 = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);
    TextStyle h2 = GoogleFonts.koHo(
        fontSize: size.width * .05, fontWeight: FontWeight.w500);

    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: size.height * .08,
          title: Text(widget.catagoryname, style: h1),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Productadd(
                  catagoryname: widget.catagoryname,
                );
              }));
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
                    colors: [Colors.grey[800], Colors.black])),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('collection', isEqualTo: widget.catagoryname)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: List.generate(
                    snapshot.data.docs.length,
                    (i) {
                      DocumentSnapshot doc = snapshot.data.docs[i];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          shadowColor: Colors.grey[500],
                          color: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Text(doc['type'], style: h2),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Productedit(
                                                              collection: doc[
                                                                  'collection'],
                                                              docname: doc.id,
                                                              type: doc['type'],
                                                              tagline: doc[
                                                                  'tagline'],
                                                              fabric:
                                                                  doc['fabric'],
                                                              fit: doc['fit'],
                                                              productsize:
                                                                  doc['size'],
                                                              details: doc[
                                                                  'details'],
                                                              wash: doc['wash'],
                                                              price:
                                                                  doc['price'],
                                                              time: doc['time'],
                                                              i1: doc['image1'],
                                                              i2: doc['image2'],
                                                              i3: doc['image3'],
                                                              i4: doc['image4'],
                                                              i5: doc['image5'],
                                                              i6: doc['image6'],
                                                            )));
                                              },
                                              child: Text(
                                                'EDIT',
                                                style: GoogleFonts.koHo(),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: MaterialButton(
                                              onPressed: () {
                                                showAlertDialog(
                                                    context, doc.id);
                                              },
                                              child: Text(
                                                'DELETE',
                                                style: GoogleFonts.koHo(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            )));
  }

  showAlertDialog(BuildContext context, docid) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("DELETE THIS PRODUCT?",
          style: GoogleFonts.koHo(fontWeight: FontWeight.bold)),
      content: Text("Would you like to delete this product?"),
      actions: [
        TextButton(
          child: Text(
            "Yes, Delete",
            style: GoogleFonts.koHo(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('product')
                .doc(docid)
                .delete();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                content: Text(
                  'PRODUCT DELETED',
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
