import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Editcatagory extends StatefulWidget {
  final String name, docname, i1, i2;

  final Timestamp time;
  Editcatagory({
    this.name,
    this.docname,
    this.time,
    this.i1,
    this.i2,
  });

  @override
  _EditcatagoryState createState() => _EditcatagoryState();
}

TextEditingController controli1 = TextEditingController();
TextEditingController controli2 = TextEditingController();
TextEditingController controlname = TextEditingController();

class _EditcatagoryState extends State<Editcatagory> {
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
          title: Text('Edit ' + widget.name, style: h1),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey.shade800, Colors.black])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: ListView(
                children: [
                  customtextformfield(controlname, 'CATAGORY NAME'),
                  customtextformfield(controli1, "IMAGE1"),
                  customtextformfield(controli2, "IMAGE2"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        onPressed: () {
                          controli1.clear();
                          controli2.clear();
                          controlname.clear();
                        },
                        child: Text('CLEAR',
                            style: GoogleFonts.koHo(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MaterialButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
                          onPressed: () {
                            if (controli1.text == '') {
                              controli1.text = widget.i1;
                            }
                            if (controli2.text == '') {
                              controli2.text = widget.i2;
                            }
                            if (controlname.text == '') {
                              controlname.text = widget.name;
                            }

                            FirebaseFirestore.instance
                                .collection('catagories')
                                .doc(widget.docname)
                                .set({
                              'image1': controli1.text,
                              'image2': controli2.text,
                              'name': controlname.text,
                              'time': widget.time,
                            });

                            controli1.clear();
                            controli2.clear();
                            controlname.clear();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'PRODUCT EDITED',
                                  style: GoogleFonts.koHo(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                )));
                            Navigator.pop(context);
                          },
                          child: Text('UPDATE',
                              style: GoogleFonts.koHo(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            )));
  }

  customtextformfield(control, label) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: control,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.koHo(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
