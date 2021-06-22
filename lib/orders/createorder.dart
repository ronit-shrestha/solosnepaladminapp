import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController controlname = TextEditingController();
TextEditingController controllocation = TextEditingController();
TextEditingController controlnumber = TextEditingController();
TextEditingController controlsize = TextEditingController();
TextEditingController controlheightweight = TextEditingController();
TextEditingController controlorderdetails = TextEditingController();

final key = GlobalKey<FormState>();

class Createorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          title: Text('CREATE ORDER',
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
                customtextformfield(controlname, 'FULL NAME'),
                customtextformfield(controllocation, 'FULL LOCATION'),
                numbertextformfield(controlnumber, 'CONTACT NUMBER'),
                optionaltextformfield(controlsize, 'SIZE'),
                optionaltextformfield(controlheightweight, 'HEIGHT & WEIGHT'),
                customtextformfield(controlorderdetails, 'ORDER DETAILS'),
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
                        controllocation.clear();
                        controlnumber.clear();
                        controlsize.clear();
                        controlheightweight.clear();
                        controlorderdetails.clear();
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
                                .collection('orders')
                                .doc('neworders')
                                .collection('neworders')
                                .add({
                              'date': Timestamp.now(),
                              'name': controlname.text,
                              'location': controllocation.text,
                              'number': controlnumber.text,
                              'preferedsize': controlsize.text,
                              'heightweight': controlheightweight.text,
                              'orderdetails': controlorderdetails.text,
                            });

                            controlname.clear();
                            controllocation.clear();
                            controlnumber.clear();
                            controlsize.clear();
                            controlheightweight.clear();
                            controlorderdetails.clear();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'NEW ORDER CREATED',
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

  numbertextformfield(control, label) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        keyboardType: TextInputType.number,
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

  optionaltextformfield(control, label) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: control,
        decoration: InputDecoration(
            helperText: 'optional',
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
