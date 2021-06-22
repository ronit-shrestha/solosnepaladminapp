import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController controlname = TextEditingController();
TextEditingController controli2 = TextEditingController();
TextEditingController controli1 = TextEditingController();
final key = GlobalKey<FormState>();

class Addcatagory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          title: Text('ADD A CATAGORY',
              style: GoogleFonts.koHo(
                  fontWeight: FontWeight.bold, fontSize: size.width * .06)),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey.shade800, Colors.black])),
          child: Form(
            key: key,
            child: ListView(
              children: [
                customtextformfield(controlname, 'NAME'),
                customtextformfield(controli1, 'IMAGE1'),
                customtextformfield(controli2, 'IMAGE2'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.white,
                      onPressed: () {
                        controlname.clear();
                        controli1.clear();
                        controli2.clear();
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
                          if (key.currentState.validate()) {
                            FirebaseFirestore.instance
                                .collection('catagories')
                                .add({
                              'time': Timestamp.now(),
                              'name': controlname.text,
                              'image1': controli1.text,
                              'image2': controli2.text,
                            });

                            controlname.clear();
                            controli1.clear();
                            controli2.clear();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'NEW CATAGORY CREATED',
                                  style: GoogleFonts.koHo(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )));
                            Navigator.pop(context);
                          }
                        },
                        child: Text('CREATE',
                            style: GoogleFonts.koHo(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  customtextformfield(control, label) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Cannot be left Empty' : null,
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
