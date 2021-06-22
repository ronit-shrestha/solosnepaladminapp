import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solosadmin/orders/customerrecords.dart';
import 'package:solosadmin/products/caragories.dart';
import '../orders/orders.dart';

class SolosAdminDrawer extends StatefulWidget {
  @override
  _SolosAdminDrawerState createState() => _SolosAdminDrawerState();
}

class _SolosAdminDrawerState extends State<SolosAdminDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextStyle textsize = GoogleFonts.koHo(fontSize: size.width * .04);

    TextStyle h1 = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);

    return SafeArea(
        child: ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(120)),
      child: Opacity(
        opacity: 0.85,
        child: Container(
          width: size.width * .6,
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.black, Colors.grey[800]])),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    height: size.height * .08,
                    child: Center(
                      child: Text('S O L O S', style: h1),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Orders();
                      }));
                    },
                    title: Text('ORDERS',
                        style: textsize.copyWith(fontWeight: FontWeight.bold)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, size: size.height * .02),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Customerrecords();
                      }));
                    },
                    title: Text('CUSTOMER RECORDS',
                        style: textsize.copyWith(fontWeight: FontWeight.bold)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, size: size.height * .02),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Catagories();
                      }));
                    },
                    title: Text('PRODUCTS',
                        style: textsize.copyWith(fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: size.height * .02,
                    ),
                  ),
                  Divider(thickness: 1),
                  // ListTile(
                  //   onTap: () {
                  //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     //   return Cart();
                  //     // }));
                  //   },
                  //   title: Text('MY CART',
                  //       style: textsize.copyWith(fontWeight: FontWeight.bold)),
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: size.height * .02,
                  //   ),
                  // ),
                  // Divider(thickness: 1),
                  // ListTile(
                  //   onTap: () {
                  //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     //   return AboutUs();
                  //     // }));
                  //   },
                  //   title: Text('ABOUT US',
                  //       style: textsize.copyWith(fontWeight: FontWeight.bold)),
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: size.height * .02,
                  //   ),
                  // ),
                  // Divider(thickness: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
