import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solosadmin/products/productedit.dart';

TextEditingController controltype = TextEditingController();
TextEditingController controltagline = TextEditingController();
TextEditingController controlfabric = TextEditingController();
TextEditingController controlfit = TextEditingController();
TextEditingController controlsize = TextEditingController();
TextEditingController controldetails = TextEditingController();
TextEditingController controlwash = TextEditingController();
TextEditingController controlprice = TextEditingController();
TextEditingController controli1 = TextEditingController();
TextEditingController controli2 = TextEditingController();
TextEditingController controli3 = TextEditingController();
TextEditingController controli4 = TextEditingController();
TextEditingController controli5 = TextEditingController();
TextEditingController controli6 = TextEditingController();

class Productadd extends StatelessWidget {
  final catagoryname;
  Productadd({this.catagoryname});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          title: Text('ADD A PRODUCT',
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
            child: ListView(
              children: [
                customtextformfield(controltype, 'TYPE'),
                customtextformfield(controltagline, 'TAGLINE'),
                customtextformfield(controlfabric, 'FABRIC'),
                Row(
                  children: [
                    Flexible(child: customtextformfield(controlfit, 'FIT')),
                    Flexible(child: customtextformfield(controlsize, 'SIZES')),
                  ],
                ),
                customtextformfield(controldetails, 'DETAILS'),
                Row(
                  children: [
                    Flexible(child: customtextformfield(controlwash, 'WASH')),
                    Flexible(child: customtextformfield(controlprice, 'PRICE')),
                  ],
                ),
                customtextformfield(controli1, 'IMAGE1'),
                customtextformfield(controli2, 'IMAGE2'),
                customtextformfield(controli3, 'IMAGE3'),
                customtextformfield(controli4, 'IMAGE4'),
                customtextformfield(controli5, 'IMAGE5'),
                customtextformfield(controli6, 'IMAGE6'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.white,
                      onPressed: () {
                        controltype.clear();
                        controlprice.clear();
                        controltagline.clear();
                        controlfabric.clear();
                        controlfit.clear();
                        controlsize.clear();
                        controldetails.clear();
                        controlwash.clear();
                        controli1.clear();
                        controli2.clear();
                        controli3.clear();
                        controli4.clear();
                        controli5.clear();
                        controli6.clear();
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
                          FirebaseFirestore.instance
                              .collection('products')
                              .add({
                            'time': Timestamp.now(),
                            'collection': catagoryname,
                            'type': controltype.text,
                            'tagline': controltagline.text,
                            'fabric': controlfabric.text,
                            'fit': controlfit.text,
                            'size': controlsize.text,
                            'details': controldetails.text,
                            'wash': controlwash.text,
                            'price': controlprice.text,
                            'image1': controli1.text,
                            'image2': controli2.text,
                            'image3': controli3.text,
                            'image4': controli4.text,
                            'image5': controli5.text,
                            'image6': controli6.text,
                          });
                          controltype.clear();
                          controlprice.clear();
                          controltagline.clear();
                          controlfabric.clear();
                          controlfit.clear();
                          controlsize.clear();
                          controldetails.clear();
                          controlwash.clear();
                          controli1.clear();
                          controli2.clear();
                          controli3.clear();
                          controli4.clear();
                          controli5.clear();
                          controli6.clear();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.transparent,
                              content: Text(
                                'NEW PRODUCT CREATED',
                                style: GoogleFonts.koHo(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )));
                          Navigator.pop(context);
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
