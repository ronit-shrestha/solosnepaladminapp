import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Productedit extends StatefulWidget {
  final String collection,
      docname,
      type,
      tagline,
      fabric,
      fit,
      productsize,
      details,
      wash,
      price,
      i1,
      i2,
      i3,
      i4,
      i5,
      i6;
  final Timestamp time;
  Productedit(
      {this.collection,
      this.docname,
      this.type,
      this.tagline,
      this.fabric,
      this.fit,
      this.productsize,
      this.details,
      this.wash,
      this.price,
      this.time,
      this.i1,
      this.i2,
      this.i3,
      this.i4,
      this.i5,
      this.i6});

  @override
  _ProducteditState createState() => _ProducteditState();
}

TextEditingController controltype = TextEditingController();
TextEditingController controltagline = TextEditingController();
TextEditingController controlfabric = TextEditingController();
TextEditingController controlfit = TextEditingController();
TextEditingController controlproductsize = TextEditingController();
TextEditingController controldetails = TextEditingController();
TextEditingController controlwash = TextEditingController();
TextEditingController controlprice = TextEditingController();

TextEditingController controli1 = TextEditingController();
TextEditingController controli2 = TextEditingController();
TextEditingController controli3 = TextEditingController();
TextEditingController controli4 = TextEditingController();
TextEditingController controli5 = TextEditingController();
TextEditingController controli6 = TextEditingController();

class _ProducteditState extends State<Productedit> {
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
          title: Text('Edit ' + widget.type, style: h1),
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
                  customtextformfield(controltype, 'TYPE'),
                  customtextformfield(controltagline, 'TAGLINE'),
                  customtextformfield(controlfabric, 'FABRIC'),
                  Row(
                    children: [
                      Flexible(child: customtextformfield(controlfit, 'FIT')),
                      Flexible(
                          child:
                              customtextformfield(controlproductsize, 'SIZE')),
                    ],
                  ),
                  customtextformfield(controldetails, 'DETAILS'),
                  Row(
                    children: [
                      Flexible(child: customtextformfield(controlwash, 'WASH')),
                      Flexible(
                          child: customtextformfield(controlprice, 'PRICE')),
                    ],
                  ),
                  customtextformfield(controli1, "IMAGE1"),
                  customtextformfield(controli2, "IMAGE2"),
                  customtextformfield(controli3, "IMAGE3"),
                  customtextformfield(controli4, "IMAGE4"),
                  customtextformfield(controli5, "IMAGE5"),
                  customtextformfield(controli6, "IMAGE6"),
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
                          controltagline.clear();
                          controlfabric.clear();
                          controlfit.clear();
                          controlproductsize.clear();
                          controldetails.clear();
                          controlwash.clear();
                          controlprice.clear();

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
                            if (controltype.text == '') {
                              controltype.text = widget.type;
                            }
                            if (controltagline.text == '') {
                              controltagline.text = widget.tagline;
                            }
                            if (controlfabric.text == '') {
                              controlfabric.text = widget.fabric;
                            }
                            if (controlfit.text == '') {
                              controlfit.text = widget.fit;
                            }
                            if (controlproductsize.text == '') {
                              controlproductsize.text = widget.productsize;
                            }
                            if (controldetails.text == '') {
                              controldetails.text = widget.details;
                            }

                            if (controlwash.text == '') {
                              controlwash.text = widget.wash;
                            }
                            if (controlprice.text == '') {
                              controlprice.text = widget.price;
                            }

                            if (controli1.text == '') {
                              controli1.text = widget.i1;
                            }
                            if (controli2.text == '') {
                              controli2.text = widget.i2;
                            }
                            if (controli3.text == '') {
                              controli3.text = widget.i3;
                            }
                            if (controli4.text == '') {
                              controli4.text = widget.i4;
                            }
                            if (controli5.text == '') {
                              controli5.text = widget.i5;
                            }
                            if (controli6.text == '') {
                              controli6.text = widget.i6;
                            }

                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(widget.docname)
                                .set({
                              'type': controltype.text,
                              'tagline': controltagline.text,
                              'fabric': controlfabric.text,
                              'fit': controlfit.text,
                              'size': controlproductsize.text,
                              'details': controldetails.text,
                              'wash': controlwash.text,
                              'price': controlprice.text,
                              'image1': controli1.text,
                              'image2': controli2.text,
                              'image3': controli3.text,
                              'image4': controli4.text,
                              'image5': controli5.text,
                              'image6': controli6.text,
                              'time': widget.time,
                              'collection': widget.collection
                            });
                            controltype.clear();
                            controltagline.clear();
                            controlfabric.clear();
                            controlfit.clear();
                            controlproductsize.clear();
                            controldetails.clear();
                            controlwash.clear();
                            controlprice.clear();
                            controli1.clear();
                            controli2.clear();
                            controli3.clear();
                            controli4.clear();
                            controli5.clear();
                            controli6.clear();
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
